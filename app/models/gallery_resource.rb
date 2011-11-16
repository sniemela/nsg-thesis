class GalleryResource < ActiveRecord::Base
  belongs_to :gallery
 
  has_attached_file :resource, :styles => { :small => "100x100>", :medium => "200x200>", :large => "800x800>" }
  attr_accessible :resource, :name, :description, :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
end
