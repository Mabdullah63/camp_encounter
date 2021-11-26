class Admins::UserApplicationsController < AdminsController
  before_action :authenticate_user!
  before_action :set_user_application, only: [:show]
  def index
    @user_applications = UserApplication.where(progress_bar: 100)
  end

  def show; end

  private
  def set_user_application
    @user_application = UserApplication.find(params[:id])
  end
end

