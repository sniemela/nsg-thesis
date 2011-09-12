class Advertise < ActiveRecord::Base
  belongs_to :client

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  has_attached_file :media

  before_save :set_price

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
    Advertise.joins(:tags).where(['tags.id in (?)', tag_ids]).select('distinct advertises.*')
  end

  def self.find_by_tags(tags)
    find_by_tag_ids(tags.map { |tag| tag.id })
  end
end
