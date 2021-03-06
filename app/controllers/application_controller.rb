class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  
  include UserSessionsHelper
  include ApplicationHelper
  include EventsHelper
  include UsersHelper
  
  def help
    @title = "Help"
  end
  
  helper_method :current_user_session, :current_user

  private

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
end
