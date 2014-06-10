class EmailPanelController < ApplicationController
	before_filter :authenticate_user!

	def index
    @jobs = Delayed::Job.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def weekly_tops
    @users = User.all
    @users.each do |user|
      @user = user
        WeeklyMailer.delay.weekly_top_stories(@user)
    end
    redirect_to email_panel_path
  end

  def progress_report
    users = User.all
    #I didn't include the WHERE statement condition, because I didn't know what we include
    users.each do |user|
      WeeklyMailer.delay.progress_report_email(user)
    end
    WeeklyMailer.delay.progress_report_email
    redirect_to email_panel_path

  end

  # I haven't set up this Yet!
  # This is for deleting and moderating Delayed Jobs
  def show
    begin
      @job = Delayed::Job.find(params[:id])
    rescue
      redirect_to [:admin,:delayed_jobs], :notice => 'That specific job has finished processing'
    end
  end

  def destroy
    @job = Delayed::Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html {redirect_to(admin_delayed_jobs_path, :notice => 'Job destroyed')}
    end
  end


end
