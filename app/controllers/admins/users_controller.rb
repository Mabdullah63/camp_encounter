class Admins::UsersController < AdminsController
  def index
    if params[:query].present?
      @pagy, @users = pagy(User.search(params[:query]).order(:id))
    elsif params[:sorting_column].present?
      @pagy, @users = pagy(User.all.order(params[:sorting_column] + " " +  params[:sort_type]))
    else
      @pagy, @users = pagy(User.all.order(:id))
    end
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
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
end
