class ArticlesController < ApplicationController
 
  layout "admin"

  before_action :confirm_logged_in
  before_action :find_category

  def index
    @articles = Article.sorted
    @articles = @category.articles.sorted
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new({:category_id => @category.id, :name => "Default"})
    @categories = @category.newspaper.categories.sorted
    @article_count = Article.count + 1
  end

   def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article created successfully."
      redirect_to(:action => 'index', :category_id => @category.id)
    else
      @categories = @category.newspaper.categories.sorted
      @article_count = Article.count + 1
      render('new')
    end
  end

  def edit
    @article = Article.find(params[:id])
    @categories = Category.order('position ASC')
    @article_count = Article.count
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:notice] = "Section updated successfully."
      redirect_to(:action => 'show', :id => @article.id, :category_id => @category.id)
    else
      @categories = Category.order('position ASC')
      @article_count = Article.count
      render('edit')
    end
  end

  def delete
    @article = Article.find(params[:id])
  end

  def destroy
    article = Article.find(params[:id]).destroy
    flash[:notice] = "Article destroyed successfully."
    redirect_to(:action => 'index', :category_id => @category.id)
  end

  private

    def article_params
      params.require(:article).permit(:category_id, :name, :position, :visible, :content_type, :content)
    end

    def find_category
      if params[:category_id]
        @category = Category.find(params[:category_id])
      end
    end

end
