class Event < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, :through => :categorizations

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings
end
