class GalleryResource < ActiveRecord::Base
  belongs_to :gallery
 
  has_attached_file :resource, :styles => { :small => "100x100#", :medium => "200x200#", :crop => "300x300>", :large => "800x800>" }, :processors => [:cropper]
  attr_accessible :resource, :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_resource, :if => :cropping?
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def resource_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(resource.path(style))
  end  
  
  private

  def reprocess_resource
    resource.reprocess!
  end
end
