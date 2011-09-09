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
end
