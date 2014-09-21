class CategoriesController < ApplicationController
  
  layout "admin"

  before_action :confirm_logged_in
  before_action :find_newspaper

  def index
    @categories = @newspaper.categories.sorted
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new({:newspaper_id => @newspaper.id, :name => "Default"})
    @newspapers = Newspaper.order('position ASC')
    @category_count = Category.count + 1
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category created successfully."
      redirect_to(:action => 'index', :newspaper_id => @newspaper.id)
    else
      @newspapers = Newspaper.order('position ASC')
      @category_count = Category.count + 1
      render('new')
    end
  end

  def edit
    @category = Category.find(params[:id])
    @newspapers = Newspaper.order('position ASC')
    @category_count = Category.count
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:notice] = "Category updated successfully."
      redirect_to(:action => 'show', :id => @category.id, :newspaper_id => @newspaper.id)
    else
      @newspapers = Newspaper.order('position ASC')
      @category_count = Category.count
      render('edit')
    end
  end

  def delete
    @category = Category.find(params[:id])
  end

  def destroy
    category = Category.find(params[:id]).destroy
    flash[:notice] = "Category destroyed successfully."
    redirect_to(:action => 'index', :newspaper_id => @newspaper.id)
  end

  private

  def category_params
     params.require(:category).permit(:newspaper_id, :name, :permalink, :position, :visible)
  end

  def find_newspaper
    if params[:newspaper_id]
       @newspaper = Newspaper.find(params[:newspaper_id])
    end
  end

end
