class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update]
  
  def show
  end

  def edit
  end

  def update
    if admin_params[:password].blank?
      admin_params.delete(:password)
      admin_params.delete(:password_confirmation)
    end

    successfully_updated = if needs_password?(@admin, admin_params)
                             @admin.update(admin_params)
                           else
                             @admin.update_without_password(admin_params)
                           end

    if successfully_updated
      sign_in(@admin, :bypass => true)
      flash[:success] = "Admin account was successfully updated!"
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])

    unless current_admin == @admin.id
      flash[:warning] = "You are not authorized to view this page"
      redirect_to root_path
    end
  end

  def admin_params
    params.require(:admin).permit(
      :name, :email, :password
    )
  end

  def needs_password?(admin, params)
    params[:password].present?
  end
end
