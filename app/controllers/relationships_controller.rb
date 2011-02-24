class RelationshipsController < ApplicationController

  include UserSessionsHelper
  include ApplicationHelper
  include EventsHelper
  include UsersHelper

  def create
    @event = Event.find(params[:relationship][:followed_id])
    current_user.follow!(@event)
    @user = current_user
    
    respond_to do |format|
      format.html
      format.json { render :json => @user}
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    
    respond_to do |format|
      format.html
      format.json { render :json => @user}
    end
  end
end
