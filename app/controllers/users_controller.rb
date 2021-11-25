class UsersController < ApplicationController
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      respond_to do |format|
        format.html { redirect_to admins_path, notice: "User successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end
end
