class UserApplicationsController < ApplicationController
  include Wicked::Wizard
  before_action :set_user_application
  before_action :check_progress, only: [:update]
  after_action :progress_bar, only: [:update]

  steps :step_one, :step_two, :step_three, :step_four, :step_five, :step_six, :step_seven, :step_eight, :step_nine, :step_ten

  def index; end

  def show
    render_wizard
  end

  def update
    @user_application.update(user_application_params)
    render_wizard @user_application
  end

  private

  def progress_bar
    if wizard_steps.any? && wizard_steps.index(step).present?
      @user_application.progress_bar = ((wizard_steps.index(step) ).to_d / (wizard_steps.count.to_d - 1)) * 100
      @user_application.save
    end
  end

  def set_user_application
    @user_application = UserApplication.find_by_id(session[:user_application_id])
  end

  def check_progress
    if @user_application.progress_bar == 100
      redirect_to wizard_path(:index), alert: "You have already submitted this application"
    end
  end

  def user_application_params
   params.require(:user_application).permit(:gender, :age, :emergency_contact, :medical_history,
    :address,  :progress_bar, :insurance, :lunch, :wifi_service, :shirt_size, :food_options, :activity)
  end
end
