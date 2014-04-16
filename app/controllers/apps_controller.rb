class AppsController < ApplicationController
  def index
    @apps = App.all
    @apps.sort! { |a, b| a.created_at <=> b.created_at }
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

  def edit
    @app = App.find(params[:id])
  end

  def update
    @app = App.find(params[:id])

    respond_to do |format|
      if @app.update_attributes(params[:app])
        format.html { redirect_to apps_url }
        #format.json { head :no_content }
      else
        format.html { render action: "edit" }
        #format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @app = App.find(params[:id])
    @app.destroy

    respond_to do |format|
      format.html { redirect_to apps_url }
      #format.json { head :no_content }
    end
  end

end