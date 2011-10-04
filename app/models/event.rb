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
  
  accepts_nested_attributes_for :showtimes, :galleries, :categories, :reject_if => :all_blank, :allow_destroy => true
  
  validates_presence_of :name, :description, :country, :address, :active_time_start, :active_time_end

  scope :most_watched, where('times_watched > ?', 0).order('times_watched desc').limit(50)
  scope :popular, where('liked_count > ?', 0).order('liked_count desc').limit(50)
  scope :recent, where('created_at >= ?', Time.zone.now - 1.week)
  scope :upcoming, joins(:showtimes).where('showtimes.start_time >= ?', Time.zone.now - 2.days).select('distinct events.*').order('showtimes.start_time ASC')
  scope :between, lambda { |from, to| where('created_at between ? and ?', from, to) }
  scope :approved, where(:approved => true)
  scope :unapproved, where(:approved => false)

  define_index do
    indexes :name
    indexes description
    indexes comments.body, :as => :comment_body
    indexes tags(:name), :as => :tag_name
    indexes submitter(:name), :as => :submitter_name

    has "RADIANS(longitude)", :as => :longitude, :type => :float
    has "RADIANS(latitude)", :as => :latitude, :type => :float

    where sanitize_sql(['approved', true])
  end

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  def approve!
    self[:approved] = true
    save!
  end

  def to_param
    "#{id}-#{name.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end

  private
    def notify_updated
      NodejsNotifier.notify('/event_updated', to_json)
    end

    def notify_created
      NodejsNotifier.notify('/event_added', to_json)
    end
  
    def notify_removed
      NodejsNotifier.notify('/event_removed', to_json)
    end
end
