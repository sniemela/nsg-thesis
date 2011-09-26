# encoding: utf-8

module ApplicationHelper
  def is_admin?
    current_user && current_user.admin?
  end
  
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
      new_object = f.object.class.reflect_on_association(association).klass.new
      fields = f.fields_for(association, [new_object], :child_index => "new_#{association}") do |builder|
        render(association.to_s.singularize + "_fields", :f => builder)
      end
      link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def tag_cloud(classes = [])
    tags = Tag.for_cloud
    max, min = 0, 0

    tags.each do |tag|
      max = tag.count.to_i if tag.count.to_i > max
      min = tag.count.to_i if tag.count.to_i < min
    end

    divisor = ((max - min) / classes.size) + 1

    tags.each do |t|
      yield t.id, t.name, classes[(t.count.to_i - min) / divisor] if t && t.name && t.id
    end
  end

  def link_to_locales
    locales = {
      :fi => 'Suomeksi',
      # :sv => 'På svenska',
      :en => 'In english',
    }

    locales.delete(I18n.locale.to_sym)

    links = locales.map do |code, title|
      locale = code
      locale = nil if code.to_s == I18n.default_locale.to_s
      link_to image_tag(code.to_s + '.png'), {:locale => locale}, :title => title
    end

    links.join(' ').html_safe
  end
end
