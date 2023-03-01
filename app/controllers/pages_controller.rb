class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[landing_page home]

  def home
    @users = User.all
  end
end
