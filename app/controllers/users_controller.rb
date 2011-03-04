class UsersController < ApplicationController
  include UserSessionsHelper
  
  def new
    @user = User.new
    @title = "Sign up"
    
    respond_to do |format|
      format.html
      format.json { render :json => @user }
    end
  end
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
    
    respond_to do |format|
      format.html
      format.json { render :json => @users}
    end
  end
  
  def show
    @user = current_user
    @events = @user.events.paginate(:page => params[:page])
    @title = @user.username
    
    respond_to do |format|
      format.html
      format.json { render :json => @user}
    end
  end
  
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'Registration was successful!.') }
        format.json  { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new"}
        format.json { render :json => @user.errors, :status => :unprocessable_entity}
      end
    end
  end
  
  def edit
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => "Profile updated.") }
        format.json { head :ok}
      else
        format.html { render :action => "edit" }
        @title = "Edit user"
        format.json  { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy 
    User.find(params[:id]).destroy
    
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
  
  def following
    @title = "Following"
    @user  = current_user
    @users = @user.following.paginate(:page => params[:page])
    
    respond_to do |format|
      format.html { render :action => 'show_follow'}
      format.json { render :json => @users }
    end
  end
  
  private

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
