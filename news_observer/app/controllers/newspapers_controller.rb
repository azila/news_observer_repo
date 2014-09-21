class NewspapersController < ApplicationController
  
  layout "admin"

  before_action :confirm_logged_in

  def index
    @newspapers = Newspaper.sorted
  end

  def show
    @newspaper = Newspaper.find(params[:id])
    @newspaper_count = Newspaper.count + 1
  end

  def new
    @newspaper = Newspaper.new({:name => "Default"})
    @newspaper_count = Newspaper.count + 1
  end

   def create
    @newspaper = Newspaper.new(newspaper_params)
    if @newspaper.save
      flash[:notice] = "Newspaper created successfully."
      redirect_to(:action => 'index')
    else
      @newspaper_count = Newspaper.count + 1
      render('new')
    end
  end

  def edit
    @newspaper = Newspaper.find(params[:id])
    @newspaper_count = Newspaper.count
  end

  def update
    @newspaper = Newspaper.find(params[:id])
    if @newspaper.update_attributes(newspaper_params)    
      flash[:notice] = "Newspaper updated successfully."
      redirect_to(:action => 'show', :id => @newspaper.id)
    else
      @newspaper_count = Newspaper.count
      render('edit')
    end
  end

  def delete
    @newspaper = Newspaper.find(params[:id])
  end

  def destroy
    newspaper = Newspaper.find(params[:id]).destroy
    flash[:notice] = "Newspaper '#{newspaper.name}' destroyed successfully."
    redirect_to(:action => 'index')
  end

 private

  def newspaper_params
    # same as using "params[:newspaper]", except that it:
    # - raises an error if :newspaper is not present
    # - allows listed attributes to be mass-assigned
    params.require(:newspaper).permit(:name, :position, :visible)
  end
end
