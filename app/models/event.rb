require 'nodejs_notifier'

class Event < ActiveRecord::Base
  has_many :showtimes, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  has_many :categorizations
  has_many :categories, :through => :categorizations
  
  has_many :galleries, :dependent => :destroy

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  belongs_to :submitter, :polymorphic => true

  after_create :notify_created
  after_update :notify_updated
  after_destroy :notify_removed
  validate :check_active_times, :if => Proc.new { |r| r.active_time_start_changed? or r.active_time_end_changed? }

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_picture, :if => :cropping?

  has_attached_file :picture, :styles => { :thumb => "40x40#", :small => "100x100#", :medium => "200x200#", :info => "200x200>", :crop => "300x300>", :large => "800x800>" }, :processors => [:cropper]

  before_save :set_active_datetimes, :set_address_and_city
  
  accepts_nested_attributes_for :showtimes, :galleries, :categories, :reject_if => :all_blank, :allow_destroy => true
  
  validates_presence_of :name, :description, :country, :address

  scope :most_watched, where('times_watched > ?', 0).order('times_watched desc').limit(50)
  scope :popular, where('liked_count > ?', 0).order('liked_count desc').limit(50)
  scope :recent, where('created_at >= ?', Time.zone.now - 1.week).order('created_at DESC')
  scope :upcoming, joins(:showtimes).where('showtimes.start_time >= ?', Time.zone.now - 2.days).select('distinct events.*').order('showtimes.start_time ASC')
  scope :between, lambda { |from, to| where('created_at between ? and ?', from, to) }
  scope :approved, where(:approved => true)
  scope :unapproved, where(:approved => false)
  scope :active, where('active_time_start <= ? and active_time_end >= ?', Time.zone.now + 10.minutes, Time.zone.now)

  define_index do
    indexes :name
    indexes description
    indexes city
    indexes address
    indexes country
    indexes comments.body, :as => :comment_body
    indexes tags(:name), :as => :tag_name
    indexes submitter(:name), :as => :submitter_name

    has "RADIANS(longitude)", :as => :longitude, :type => :float
    has "RADIANS(latitude)", :as => :latitude, :type => :float
    has showtimes(:start_time), :as => :start_time

    set_property :longitude_attr, :as => :longitude
    set_property :latitude_attr, :as => :latitude

    where sanitize_sql(['approved', true])
  end

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  def tag_names=(tag_names)
    tag_names.each do |tag_name|
      tag = Tag.find_or_initialize_by_name(tag_name.downcase)
      tags << tag if tag
    end
  end

  def set_address_and_city
    address_and_city_parts = []
    address_and_city_parts << self[:address] if self[:address]
    address_and_city_parts << self[:city] if self[:city]
    self[:address_and_city] = ""
    self[:address_and_city] = address_and_city_parts.join(', ')
  end

  def set_active_datetimes
    self[:active_time_start] = Time.zone.now + 10.minutes if self[:active_time_start].blank?
    self[:active_time_end] = Time.zone.now + 1.week if self[:active_time_end].blank?
  end

  def check_active_times
    if !self[:active_time_start].blank? && self[:active_time_start] < Time.zone.now
      errors.add(:active_time_start, I18n.t('custom_errors.cant_be_past'))
    end

    if !self[:active_time_end].blank? && self[:active_time_end] < Time.zone.now
      errors.add(:active_time_end, I18n.t('custom_errors.cant_be_past'))
    end

    if !self[:active_time_start].blank? && !self[:active_time_end].blank?
      if self[:active_time_end] < self[:active_time_start]
        errors.add(:active_time_end, I18n.t('custom_errors.cant_be_earlier'))
      end
    end
  end

  def approve!
    self[:approved] = true
    save!
  end

  def small_picture_url
    picture.url(:small)
  end

  def as_json(options = {})
    super(options).merge(:picture => small_picture_url)
  end

  def to_param
    "#{id}-#{name.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end

  def has_picture?
    !self.picture.url.include?('missing')
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def picture_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(picture.path(style))
  end

  def to_json_with_showtimes
    to_json(:include => :showtimes)
  end

  private
    def notify_updated
      NodejsNotifier.notify('/event_updated', to_json_with_showtimes) unless self.times_watched_changed?
    end

    def notify_created
      NodejsNotifier.notify('/event_added', to_json_with_showtimes)
    end
  
    def notify_removed
      NodejsNotifier.notify('/event_removed', to_json_with_showtimes)
    end

    def reprocess_picture
      picture.reprocess!
    end
end
