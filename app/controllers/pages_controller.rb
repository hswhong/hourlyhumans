class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[landing_page home]

  def home
    @users = User.all
    if params[:query].present?
      sql_query = <<~SQL
        users.first_name ILIKE :query
        OR users.task ILIKE :query
        OR users.last_name ILIKE :query
        OR users.location ILIKE :query
      SQL
      @users = User.where(sql_query, query: "%#{params[:query]}%")
    else
      @users = User.all
    end
  end
end
