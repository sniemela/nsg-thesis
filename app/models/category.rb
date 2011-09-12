class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :events, :through => :categorizations

  has_attached_file :image
end
