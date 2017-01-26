class LeadsController < ApplicationController
  before_action :authenticate_authorized_user
  before_action :set_user

  def index
    gon.user_id = params[:user_id]
  end

  def show
    @lead = Lead.find(params[:id])
    last_active_status = Status.where("lead_id = ? AND active = ?", @lead.id, true)
  end

  def new
  end

  def create
    datetime = params[:lead]["date(1i)"] + "-" + params[:lead]["date(2i)"] + "-" + params[:lead]["date(3i)"] + " " + params[:lead]["date(4i)"] + ":" + params[:lead]["date(5i)"]
    @lead = Lead.new(
    # change user_id when Devise is installed
      user_id: @user.id,
      name: params[:name],
      job_title: params[:job_title],
      company: params[:company],
      email: params[:email],
      phone: params[:phone],
      notes: params[:notes],
      last_action: datetime
    )
    if @lead.save
      status = Status.new(
        lead_id: @lead.id,
        name: "Sent Invite on LinkedIn",
        date: datetime
      )
      if status.save
        flash[:success] = "Lead was successfully saved."
        redirect_to user_lead_path(@user, @lead)
      else
        @lead.destroy
        flash[:danger] = "There was an error while saving your lead. Please try again."
        render :new
      end
    else
      render :new
    end
  end

  def edit
    @lead = Lead.find(params[:id])
  end

  def update
    @lead = Lead.find(params[:id])
    if @lead.update(
    # change user_id when Devise is installed
      user_id: 1,
      name: params[:name],
      job_title: params[:job_title],
      company: params[:company],
      email: params[:email],
      phone: params[:phone],
      notes: params[:notes]
    )
      flash[:success] = "Lead has been successfully updated."
      redirect_to user_lead_path(@user, @lead)
    else
      flash[:danger] = "There was an error while saving your lead. Please try again."
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])

    unless current_admin || current_user.id == @user.id
      flash[:warning] = "You are not authorized to view this page"
      redirect_to root_path
    end
  end
end
