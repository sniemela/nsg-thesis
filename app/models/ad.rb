class Ad < ActiveRecord::Base
  belongs_to :client

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  has_attached_file :media

  before_save :set_price

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
    Advertise.joins(:tags).where(['tags.id in (?)', tag_ids]).select('distinct ads.*')
  end

  def self.find_by_tags(tags)
    find_by_tag_ids(tags.map { |tag| tag.id })
  end
end
