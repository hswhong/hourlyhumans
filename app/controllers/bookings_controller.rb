class BookingsController < ApplicationController

  def index
    @today = Date.today
    @bookings_active = Booking.where(user_booker_id: current_user).where("end_date >= ?", @today).order(:start_date)
    @bookings_completed = Booking.where(user_booker_id: current_user).where("end_date < ?", @today).order(:start_date)
  end

  def new
    @user = User.find(params[:user_id])
    @booking = Booking.new
  end

  def create
    @user = current_user
    @booking = Booking.new(booking_params)
    @booking.user_booker_id = current_user.id
    @booking.user_bookee_id = User.find(params[:user_id]).id
  # Temporarily set while routes are reconfigured
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
