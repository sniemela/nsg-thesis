class Ad < ActiveRecord::Base
  belongs_to :client
  default_scope order('ads.price desc')

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  scope :unconfirmed, where(:confirmed => false)
  scope :confirmed, where(:confirmed => true)

  has_attached_file :media

  before_save :set_price

  validates :start_time, :presence => true, :format => { :with => /\d{4}\-\d{2}\-\d{2}\s\d{2}\:\d{2}\:\d{2}/ }

  def confirm!
    self[:confirmed] = true
    save!
  end

  def tags=(tagstr)
    tag_names = tagstr.scan(/[A-Za-z0-9]+/)
    tag_names = (tag_names || []).uniq
    tag_objects = tag_names.map { |name| Tag.find_or_initialize_by_name(name.downcase) }
    tags << tag_objects
  end

  def set_price
    self[:price] = calculate_price
  end

  def calculate_price
    (tags.size * 5) + (duration_in_days * 5).round
  end

  def duration_in_days
    (end_time - start_time) / 24 / 60 / 60
  end

  def self.find_by_tag_ids(tag_ids)
    ads = Ad.joins(:tags).where(['tags.id in (?)', tag_ids]).select('distinct ads.*') || []
    other_ads = Ad.joins(:tags).where(['tags.id not in (?)', tag_ids]).select('distinct ads.*')
    ads + other_ads
  end

  def self.find_by_tags(tags)
    find_by_tag_ids(tags.map { |tag| tag.id })
  end
end
