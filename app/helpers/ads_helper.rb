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

  def elements_for_ads(ads)
    output = ""
    for ad in ads
      output += "<div class=\"ad\">" + element_for_media(ad.media.to_s) + "</div>"
    end
    output.html_safe
  end
end
