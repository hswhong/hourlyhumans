class BookingsController < ApplicationController

  def index
    @bookings = Booking.where(user_booker_id: current_user)
  end

  def new
    @booking = Booking.new
  end

  def create
    @user = current_user
    @booking = Booking.new(booking_params)
    @booking.user_booker_id = @user.id
    @booking.user_bookee_id = @user.id # Temporarily set while routes are reconfigured
    if @booking.save
      redirect_to user_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end
  def show
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price, :user_bookee_id, :user_booker_id, :hours_per_day, :description)
  end
end
