class EventsController < ApplicationController

  def index
    @events = Event.all
    @page = "calendar"
  end
end
