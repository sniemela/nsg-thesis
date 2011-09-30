class GalleryResource < ActiveRecord::Base
  belongs_to :gallery
  
  has_attached_file :resource, :styles => { :small => "100x100#", :medium => "200x200#" }
end
