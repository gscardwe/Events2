class PagesController < ApplicationController
  
  include UserSessionsHelper
  include ApplicationHelper
  include EventsHelper
  include UsersHelper
  
  def home
    @title = "Home"
    @event = Event.new if signed_in?
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end

end
