class UsersController < ApplicationController
  before_action :authenticate_authorized_user
  before_action :set_user, only: [:show, :edit, :update]
  
  def show
  end

  def edit
  end

  def update
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    successfully_updated = if needs_password?(@user, user_params)
                             @user.update(user_params)
                           else
                             @user.update_without_password(user_params)
                           end

    if successfully_updated
      sign_in(@user, :bypass => true)
      flash[:success] = "User account was successfully updated!"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])

    unless current_admin || current_user.id == @user.id
      flash[:warning] = "You are not authorized to view this page"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(
      :name, :email, :password, :timezone, :grad_city, :grad_date, :current_city, :current_state
    )
  end

  def needs_password?(user, params)
    params[:password].present?
  end
end
