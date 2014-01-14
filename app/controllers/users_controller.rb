class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :http_basic_authentication, :only => :access
  load_and_authorize_resource
  # GET /users
  # GET /users.json

  def index
   
    if params[:tag]
      @users = User.where(:program => "Winter 2014").text_search(params[:query]).tagged_with(params[:tag]).page(params[:page]).per(10)
      @hash = Gmaps4rails.build_markers(@users) do |user, marker|
        marker.lat user.latitude
        marker.lng user.longitude
        marker.infowindow user.first_name
      end
    respond_to do |format|
      format.html # index.html.erb
      format.js 
      #format.json { render json: @users }
    end
    elsif params[:tag].to_s ==~ /^\s*$/
      @users = User.where(:program => "Winter 2014").text_search(params[:query]).page(params[:page]).per(10)
      @hash = Gmaps4rails.build_markers(@users) do |user, marker|
        marker.lat user.latitude
        marker.lng user.longitude
      end
    respond_to do |format|
      format.html # index.html.erb
      format.js 
      #format.json { render json: @users }
    end
    else
      @users = User.where(:program => "Winter 2014").text_search(params[:query]).page(params[:page]).per(10)
      @hash = Gmaps4rails.build_markers(@users) do |user, marker|
        marker.lat user.latitude
        marker.lng user.longitude
      end
    respond_to do |format|
      format.html # index.html.erb
      format.js 
      #format.json { render json: @users }
    end
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @courses = Course.all
    @assignments = Assignment.all
    @user_assignments = UserAssignment.all
  
    if @user
      render action: :show
    else
      render file: 'public/404', status: 404, formats: [:html]
    end

    def email_register
      if @user
        UserRegistered.registration_confirmation(@user).deliver
      else
      end
    end
  end



  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    unauthorized! if cannot? :update, @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    unauthorized! if cannot? :update, @user

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        #format.json { head :no_content }
      else
        format.html { render action: "edit" }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      #format.json { head :no_content }
    end
  end

  def list
    @users = User.all
    respond_to do |format|
      format.html # list.html.erb
      #format.json { render json: @users }
    end
  end

end
