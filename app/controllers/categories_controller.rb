class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end
  
  def new
    @category = Category.new
    
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @category = Category.new(params[:category])
    
    respond_to do |format|
      if @category.save
        format.html { redirect_to(categories_url, :notice => 'Category added.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def show
    @category = Category.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    
    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to(categories_url, :notice => 'Category updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    
    respond_to do |format|
      format.html { redirect_to(categories_url) }
    end
  end
end
