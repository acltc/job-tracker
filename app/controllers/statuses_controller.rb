class StatusesController < ApplicationController

  def create
    @lead = Lead.find(params[:lead_id].to_i)
    last_active_status = Status.where("lead_id = ? AND active = ?", @lead.id, true)

    datetime = params[:date]["date(1i)"] + "-" + params[:date]["date(2i)"] + "-" + params[:date]["date(3i)"] + " " + params[:date]["date(4i)"] + ":" + params[:date]["date(5i)"]

    @status_to_update = Status.where("lead_id = ? AND name = ?", @lead.id, params[:name]).last

    if @status_to_update
      if @status_to_update.update(notes: params[:notes])
        flash[:success] = "Your lead status has been successfully updated."
        redirect_to user_lead_path(@lead.user_id, @lead.id)
      else
        flash[:danger] = "An error occured when updating your lead status. Please try again."
        redirect_to user_lead_path(@lead.user_id, @lead.id)
      end
    else
      if last_active_status.update(active: false)
        status = Status.new(
          name: params[:name],
          lead_id: @lead.id,
          notes: params[:notes],
          date: datetime
        )
        if status.save
          if @lead.update(last_action: datetime)
            flash[:success] = "Your lead status has been successfully updated."
            redirect_to user_lead_path(@lead.user_id, @lead.id)
          else
            flash[:danger] = "An error occured when updating your lead status. Please try again."
            redirect_to user_lead_path(@lead.user_id, @lead.id)
          end
        else
          flash[:danger] = "An error occured when updating your lead status. Please try again."
          redirect_to user_lead_path(@lead.user_id, @lead.id)
        end
      else
        flash[:danger] = "An error occured when updating your lead status. Please try again."
        redirect_to user_lead_path(@lead.user_id, @lead.id)
      end
    end
  end
end
