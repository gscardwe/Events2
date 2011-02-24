class EventsController < ApplicationController

  before_filter :authorized_user, :only => :destroy
  
  include UserSessionsHelper
  include ApplicationHelper
  include EventsHelper
  include UsersHelper
  
  # GET /events
  # GET /events.xml
  def index
    @title = "All events"
    @events = Event.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.json { render :json => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
      format.json { render :json => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @title = "Create"
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
      format.json { render :json => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = current_user.events.build(params[:event])
    @event.user_id = current_user.id

    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
        format.json  { render :json => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        format.json  { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        format.json  { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
  
  def followers
    @title = "Followers"
    @event = Event.find(params[:id])
    @events = @event.followers.paginate(:page => params[:page])
    respond_to do |format|
     format.html
     format.json { render :json => @events}
    end
  end
  
  private 
    def authorized_user
      @event = Event.find(params[:id])
      redirect_to root_path unless current_user?(@event.user)
    end
end
