class HomeController < ApplicationController
  def index
    redirect_to new_user_registration_url
  end
end
