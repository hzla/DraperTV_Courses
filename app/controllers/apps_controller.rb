class AppsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @apps = App.all 
  end
  
  def new
    @app = App.new
    if user_signed_in?
      redirect_to courses_path
    end
  end

  def create
    @app = App.new(params[:app])

    respond_to do |format|
      if @app.save
        format.html { redirect_to '/apply', notice: 'Thank you for applying to Draper University Online! We will contact you by the posted Notification date.' }
        format.json { render json: @app, status: :created, location: @app }
      else
        format.html { render action: "new" }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end
  
end