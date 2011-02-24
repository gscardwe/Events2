class UserSessionsController < ApplicationController
  include UserSessionsHelper
  include EventsHelper
  

  # GET /user_sessions/new
  # GET /user_sessions/new.xml
  def new
    @user_session = UserSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user_session }
    end
  end

  # POST /user_sessions
  # POST /user_sessions.xml
  def create
    @user_session = UserSession.new(params[:user_session])

    respond_to do |format|
      if @user_session.save
        format.html { redirect_to(root_url, :notice => 'Successfully logged in.') }
        format.json  { render :json => @user_session, :status => :created, :location => @user_session }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @user_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.xml
  def destroy
    @user_session = UserSession.find(params[:id])
    @user_session.destroy

    respond_to do |format|
      format.html { redirect_to(root_url, :notice => "Successfully logged out.") }
      format.json  { head :ok }
    end
  end
end
