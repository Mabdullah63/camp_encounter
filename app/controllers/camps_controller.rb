class CampsController < ApplicationController
  before_action :set_camp, only: %i[ show edit update destroy start_application]
  before_action :check_end_date, only: [:start_application]
  before_action :if_user_application, only: [:show]

  def index
    @camps = Camp.all.order(:id)
  end

  def show
  end

  def start_application
      @user_application = UserApplication.find_or_create_by(user_id: current_user.id, camp_id: @camp.id)
      session[:user_application_id] = @user_application.id
      redirect_to user_application_path(:step_one)
  end

  private

  def if_user_application
    @user_application = UserApplication.find_by(user_id: current_user.id, camp_id: @camp.id)
    if !@user_application.nil?
      session[:user_application_id] = @user_application.id
      redirect_to user_application_path(:index)
    end
  end

  def check_end_date
    if @camp.end_date < Time.now
      redirect_to camps_path, alert: "please participate in next camp and not allow to start the camp"
    end
  end

  def set_camp
    @camp = Camp.find(params[:id])
  end

  def camp_params
    params.require(:camp).permit(:name, :start_date, :end_date, :camp_type)
  end
end
