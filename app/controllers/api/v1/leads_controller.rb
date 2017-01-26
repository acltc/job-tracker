class Api::V1::LeadsController < ApplicationController
  before_action :authenticate_authorized_user
  
  def index
    @leads = Lead.where(user_id: params[:user_id]).sort_by(&:progress_level).reverse
  end
end
