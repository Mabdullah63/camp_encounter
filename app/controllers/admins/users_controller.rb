class Admins::UsersController < AdminsController
before_action :authenticate_user!
before_action :set_user, only: [:show]
before_action :correct_user, only: [:edit, :update, :destroy]
  def index
    if params[:query].present?
      @pagy, @users = pagy(User.search(params[:query]).order(:id))
    elsif params[:sorting_column].present?
      @pagy, @users = pagy(User.all.order(params[:sorting_column] + " " +  params[:sort_type]))
    else
      @pagy, @users = pagy(User.all.order(:id))
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      respond_to do |format|
        format.html { redirect_to admins_path, notice: "User successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admins_users_path, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def correct_user
    @user=User.find_by(id: params[:id])
    redirect_to admins_users_path, notice: "Not authorized to edit this user" if @user.nil? || @user.admin?
  end


  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :country_code, :user_id, :country)
    end
end
