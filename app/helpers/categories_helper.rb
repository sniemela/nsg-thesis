module CategoriesHelper
  def category_list(categories)
    elements = categories.map { |category| link_to category.name, category }
    elements.join(', ').html_safe
  end
end
