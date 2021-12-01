class AdminsController < ApplicationController
  def index
    @pagy, @users = pagy(User.order(:id))
  end
end
