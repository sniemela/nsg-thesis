class CategoriesController < ApplicationController
  before_filter :admin_required, :except => [:index, :show]
  add_breadcrumb I18n.t('title.categories'), :categories_path

  def index
    @categories = Category.all
  end
  
  def new
    add_breadcrumb I18n.t('title.add_category'), :new_category_path    
    @category = Category.new
  end
  
  def create
    @category = Category.new(params[:category])
    
    if @category.save
      redirect_to categories_url, :flash => { :success => 'Category added' }
    else
      render :new
    end
  end
  
  def show
    @category = Category.find_by_name(params[:id])
    raise ActiveRecord::RecordNotFound unless @category
    @ads = Ad.find_by_tag_ids(@category.tags.select('tags.id'))
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    
    if @category.update_attributes(params[:category])
      redirect_to categories_url, :flash => { :success => 'Category updated.' }
    else
      render :edit
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    
    redirect_to categories_url
  end
end
