class EventsController < ApplicationController


  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @event = Event.new(params[:event])
    sidebarindex
    @page = "calendar"
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    sidebarindex
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    @event.user_id = current_user[:id]
    @users = User.all
    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path }

        if current_user.role == "admin"
          eventEmail(@event).delay
        end
      else
        format.html { render action: "new" }
        #format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def eventEmail(event)
    if DateTime.now.to_date == @event.start_time.to_date || DateTime.tomorrow.to_date == @event.start_time.to_date
      #ReminderMailer.delay(queue: "#{@event.name}_letter", run_at: 1.seconds.from_now).events_reminder(@event)
    else
      time = @event.start_time.to_date - 24.hours
      #ReminderMailer.delay(queue: "#{@event.name}_letter", run_at: time).events_reminder(@event)
    end
  end
  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event }
        #format.json { head :no_content }
      else
        format.html { render action: "edit" }
        #format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      #format.json { head :no_content }
    end
  end
end
