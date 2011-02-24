module UserSessionsHelper

  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user 
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user?(user)
    user == current_user
  end
  
end
