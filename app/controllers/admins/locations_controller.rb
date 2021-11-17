class Admins::LocationsController < AdminsController
  before_action :set_location, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    if params[:query].present?
      @pagy, @locations = pagy(Location.search(params[:query]).order(:id))
    elsif params[:sorting_column].present?
      @pagy, @locations = pagy(Location.all.order(params[:sorting_column] + " " +  params[:sort_type]))
    else
      @pagy, @locations = pagy(Location.all.order(:id))
    end
  end

  def show
    @location = Location.find params[:id]
  end

  def new
    @location = Location.new
  end

  def edit
  end

  def create
    @location = Location.new(location_params)
    respond_to do |format|
      if @location.save
        format.html { redirect_to admins_locations_path, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to admins_locations_path, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to admin_locations_path, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:name)
  end
end
