class LeadsController < ApplicationController
  before_action :authenticate_authorized_user

  def index
    gon.user_id = params[:user_id]
  end

  def new
  end

  def create
    @user = User.find(params[:user_id])
    @lead = Lead.new(
    # change user_id when Devise is installed
      user_id: @user.id,
      name: params[:name],
      job_title: params[:job_title],
      company: params[:company],
      email: params[:email],
      phone: params[:phone],
      notes: params[:notes],
      last_action: params[:date]
    )
    if @lead.save
      status = Status.new(
        lead_id: @lead.id,
        name: "Sent Invite on LinkedIn",
        date: params[:date]
      )
      if status.save
        flash[:success] = "Lead was successfully saved."
        redirect_to user_lead_path(@user)
      else
        @lead.destroy
        flash[:danger] = "There was an error while saving your lead. Please try again."
        render :new
      end
    else
      render :new
    end
  end
end
