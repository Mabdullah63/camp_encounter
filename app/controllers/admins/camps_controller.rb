class Admins::CampsController < AdminsController
  before_action :set_camp, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    if params[:query].present?
      @pagy, @camps = pagy(Camp.search(params[:query]).order(:id))
    elsif params[:sorting_column].present?
      @pagy, @camps = pagy(Camp.all.order(params[:sorting_column] + " " +  params[:sort_type]))
    else
      @pagy, @camps = pagy(Camp.all.order(:id))
    end
  end

  def show
  end

  def new
    @camp = Camp.new
  end

  def edit
  end

  def create
    @camp = Camp.new(camp_params)

    respond_to do |format|
      if @camp.save
        format.html { redirect_to admins_camps_path, notice: "Camp was successfully created." }
        format.json { render :show, status: :created, location: admins_camps_url }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @camp.update(camp_params)
        format.html { redirect_to admins_camps_path, notice: "Camp was successfully updated." }
        format.json { render :show, status: :ok, location: admins_camps_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @camp.destroy
    respond_to do |format|
      format.html { redirect_to admins_camps_url, notice: "Camp was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_camp
      @camp = Camp.find(params[:id])
    end

    def camp_params
      params.require(:camp).permit(:name, :start_date, :end_date, :camp_type, :location_ids [])
    end
end
