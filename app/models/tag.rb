class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :taggable, :through => :taggings

  def self.for_cloud
    Tag.joins(:taggings).select('tags.name, tags.id, count(*) as count').order('name desc').limit(50)
  end
end
