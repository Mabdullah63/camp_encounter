class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:destroy]

  def destroy
    if @user.destroy
      flash[:notice] = "User destroyed successfully"
    else
      flash[:error] = @user.errors.full_messages.to_sentence
    end

    redirect_to admins_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
