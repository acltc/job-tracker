class LeadsController < ApplicationController
  before_action :authenticate_authorized_user

  def index
    @user = User.find(params[:user_id])
    gon.user_id = params[:user_id]
  end

  def new
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
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
      redirect_to "/leads/#{@lead.id}"
    else
      flash[:danger] = "There was an error while saving your lead. Please try again."
      render :edit
    end
  end
end
