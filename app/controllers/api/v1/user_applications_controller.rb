class Api::V1::UserApplicationsController < Api::BaseController
  before_action :set_user_application, only: %i[show destroy update]
  def index
    @user_applications = UserApplication.all
    render json: @user_applications
  end

  def show
    render json: @user_application
  end

  def create
    @user_application = UserApplication.new(user_application_params)
    if @user_application.save
      render json: @user_application
    else
      render json: @user_application.errors.full_messages
    end
  end

  def update
    if @user_application.update(user_application_params)
      render json: @user_application
    else
      render json: @user_application.errors.full_messages
    end
  end

  def destroy
    if @user_application.destroy
      render json: { alert: "Application was destroyed" }
    end
  end

  private

  def set_user_application
    @user_application = UserApplication.find(params[:id])
  end

  def user_application_params
   params.permit(:gender, :age, :emergency_contact, :medical_history,
    :address,  :progress_bar, :insurance, :lunch, :wifi_service, :shirt_size, :food_options, :activity)
  end
end
