class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :http_basic_authentication, :only => :access
  load_and_authorize_resource
  # GET /users
  # GET /users.json

  def index
    @users = User.where.not(role: 'admin')
    @q = User.search(params[:q])
    @users= @q.result(distinct: true).order('first_name').page(params[:page]).per(25)

    #@leaders = User.where("pcounter is not null").order('pcounter DESC').limit(10)
    @leaders = User.where.not(role: 'admin').order('pcounter').limit(10)
  end

  def workreport
    @users = User.all
    @courses = Course.all
    @assignments = Assignment.all
    @user_assignments = UserAssignment.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.friendly.find(params[:id])
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
      if @user.update_attributes(user_params)
        format.html { redirect_to student_profile_path(@user), notice: 'User was successfully updated.' }
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


  #   # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :remember_me, :superhero_power, :team, :skype, :gmail, :instagram, :angellist, :dribbble, :github,
        :bio, :city, :country, :facebook, :first_name, :last_name, :linkedin, :program, :state, :street_address, :twitter, :zip, :online, :employment,
        :latitude, :longitude, :eventReminder,
        :avatar, :tag_list, :ncounter, :pcounter,
        :name, :skill_ids,:current_password)


    end
end
