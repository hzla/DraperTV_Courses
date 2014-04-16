class EventsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @event = Event.new(params[:event])

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @commentable = @event
    @comments = @commentable.user_comments.order(:created_at)
    @comment = UserComment.new

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @event }
    end
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

        # ReminderMailer.events_reminder(@event).deliver
        # cur_ack = (Time.now - (@event.start_time - 1.day)).to_i / 1.day
        cur_ack = (Time.now - (@event.start_time)).to_i / 1.day
        cur_ack = cur_ack.abs
          if cur_ack < 0
            ReminderMailer.delay(queue: "#{@event.name}_letter", run_at: 1.seconds.from_now).events_reminder(@event)
          else
            ReminderMailer.delay(queue: "#{@event.name}_letter", run_at: cur_ack.days.from_now).events_reminder(@event)
          end

        #format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        #format.json { render json: @event.errors, status: :unprocessable_entity }
      end
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
