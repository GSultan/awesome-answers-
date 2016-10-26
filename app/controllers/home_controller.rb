class HomeController < ApplicationController

  #this method is called 'action'
  def index
    #this will render views/homes/index.html.erb and it will Use
    #views/layours/application.html.erb
    #
    # render :index, layout: 'application'
    #rails automatically renders the layout from the appropriate irectory
    #rails takes the second format as the argument ,  in index.html.erb
  end

  def contact
    #if you wanna do something different, you can write
    #index: something else
  end

  def contact_submit
    @name = params[:full_name]
  end
end
