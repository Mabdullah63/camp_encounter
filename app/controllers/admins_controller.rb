class AdminsController < ApplicationController
  def index
    #@users=User.all.order(:id)
    @pagy, @users = pagy(User.all.order(:id))
  end
end
