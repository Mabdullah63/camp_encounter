class CampsController < ApplicationController
  before_action :set_camp, only: %i[ show edit update destroy start_application]

  def index
    @camps = Camp.all.order(:id)
  end

  def show
  end

  def start_application
    @user_application = UserApplication.find_or_create_by(user_id: current_user.id, camp_id: @camp.id)
    session[:user_application_id] = @user_application.id
    if @user_application.progress_bar == 0

      redirect_to user_application_path(:step_one)
    else
      redirect_to user_applications_path
    end
  end

  private

  def set_camp
    @camp = Camp.find(params[:id])
  end

  def camp_params
    params.require(:camp).permit(:name, :start_date, :end_date, :camp_type)
  end
end





