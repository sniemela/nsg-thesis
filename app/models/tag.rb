class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :taggables, :through => :taggings

  before_save :to_downcase

  def to_downcase
    self[:name].downcase!
  end

  def self.for_cloud
    Tag.joins(:taggings).select('tags.name, tags.id, count(tags.id) as count').order('name desc').limit(50).group('tags.id')
  end
end
