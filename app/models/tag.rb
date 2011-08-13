class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :taggable, :through => :taggings
end
