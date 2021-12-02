class AdminsController < ApplicationController
  def index
    if params[:query].present?
      @pagy, @users = pagy(User.search(params[:query]).order(:id))
    else
      @pagy, @users = pagy(User.order(:id))
    end
  end
end
