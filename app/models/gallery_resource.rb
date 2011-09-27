class GalleryResource < ActiveRecord::Base
  belongs_to :gallery
  
  has_attached_file :resource, :styles => { :thumb => "150x100>", :medium => "320x240>" }
end
