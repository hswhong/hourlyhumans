class BookingsController < ApplicationController
  def index
  end

  def create
    @user = current_user
    @booking = Booking.new(booking_params)
    @booking.user = @user
    if @booking.save
      redirect_to user_path(@user)
    else
      render :new, status: :unprocessable_entity
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price, :user_bookee_id, :user_booker_id)
  end
end
