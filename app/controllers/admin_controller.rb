class AdminController < ApplicationController
  def index
    @user=User.all.order(:id)
  end
end
