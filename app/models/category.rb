class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :events, :through => :categorizations

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  has_attached_file :image
end
