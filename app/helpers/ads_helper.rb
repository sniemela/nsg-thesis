module AdsHelper
  def is_image?(filename)
    filename =~ /jpg|jpeg|png|gif/i
  end

  def is_flash?(filename)
    filename =~ /swf/i
  end

  def element_for_media(filename)
    if is_image?(filename)
      image_tag filename, :width => 200, :height => 200
    elsif is_flash?(filename)
      # create flash element
      filename
    else
      filename
    end
  end
end
