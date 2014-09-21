class PublicController < ApplicationController
  
  layout 'public'

  before_action :setup_navigation

  def index
    # intro text
  end

  def show
    @category = Category.where(:permalink => params[:permalink], :visible => true).first
    if @category.nil?
      redirect_to(:action => 'index')
    else
      # display the page content using show.html.erb
    end
  end

  private

    def setup_navigation
      @newspapers = Newspaper.visible.sorted
    end

end
