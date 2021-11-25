class AdminsController < ApplicationController
  def index
    @pagy, @users = pagy(User.all.order(:id))
  end
end
