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
      format.html { redirect_to(@user, :notice => 'Following event. Now finish the tasks!') }
      format.json { render :json => @user}
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    
    respond_to do |format|
      format.html { redirect_to(current_user, :notice => 'Quitter!') }
      format.json { render :json => @user}
    end
  end
  
  def show
    @user = current_user
    @event = Event.find(params[:relationship][:followed_id])
    @relationship = Relationship.find(params[@user.id][@event.id])
    
    respond_to do |format|
      format.html { redirect_to('relationships/show')}
      format.json { render :json => @user}
    end
  end
  
  def index
    @title = "Events Tasks"
    @relationships = Relationship.paginate(:page => params[:page])
    
    respond_to do |format|
      format.html
      format.json { render :json => @users}
    end
  end
end
