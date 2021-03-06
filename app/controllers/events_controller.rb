class EventsController < ApplicationController
  before_filter :set_the_header
  before_filter :set_user
  before_filter :set_event, :only => [:show, :edit, :update, :destroy]


  def index
    @events = @user.events
  end

  def show; end

  def new
    @event = @user.events.new(:starts_at => params[:day])
    respond_to do |format|
      format.js { render :action => 'edit'}
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @event = @user.events.new(event_params)
    
    if @event.save
      flash[:success] = '**Event** was **successfully saved**.'
    else
      flash[:fail] = '**Failed** to **save event**.'
    end

    redirect_to user_schedule_path
  end

  def update
    if @event.update(event_params)
      flash[:success] = '**Event** was **successfully saved**.'
    else
      flash[:fail] = '**Failed** to **save event**.'
    end

    redirect_to user_schedule_path
  end

  def destroy
    @event.destroy

    flash[:success] = '**Event** was **successfully destroyed**.'
    redirect_to user_schedule_path
  end
  
  private
  
  def set_the_header
    @the_header = :settings
  end

  def set_user
    @user = current_user
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    # params[:event][:starts_at] = Date.parse(params[:event][:starts_at]).to_s
    # params[:event][:ends_at] = Date.parse(params[:event][:ends_at]).to_s if params[:event][:ends_at]
    
    params[:event][:user_ids].reject!{ |id| id.empty? } << current_user.id
    params[:event].permit!
    params[:event].merge(:created_by_id => current_user.id)
  end

end
