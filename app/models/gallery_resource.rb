class GalleryResource < ActiveRecord::Base
  belongs_to :gallery
  
  has_attached_file :resource
end
