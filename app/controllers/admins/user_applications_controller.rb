class Admins::UserApplicationsController < AdminsController
  before_action :authenticate_user!
  before_action :set_user_application, only: [:show, :edit, :update]

  def index
    @user_applications = UserApplication.where(progress_bar: 100)
  end

  def show; end

  def edit
  end

  def update
    if @user_application.update(user_application_params)
      flash[:notice] = "user_application updated successfully"
    else
      flash[:error] = @user_application.errors.full_messages.to_sentence
    end

    redirect_to admins_user_applications_path
  end

  private

  def set_user_application
    @user_application = UserApplication.find(params[:id])
  end

  def user_application_params
   params.require(:user_application).permit(:gender, :age, :emergency_contact, :medical_history,
    :address,  :progress_bar, :insurance, :lunch, :wifi_service, :shirt_size, :food_options, :activity)
  end
end

