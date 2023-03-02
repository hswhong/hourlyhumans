class BookingsController < ApplicationController
  def index
    @today = Date.today
    @user = User.find(params[:user_id])
    @bookings_requested = Booking.where(user_bookee_id: current_user).where(is_accepted: nil).order(:start_date)
    @bookings_as_bookee_active = Booking.where(user_bookee_id: current_user).where("end_date >= ?",
                                                                                   @today).where(is_accepted: true).order(:start_date)
    @bookings_as_bookee_completed = Booking.where(user_bookee_id: current_user).where("end_date < ?",
                                                                                      @today).where(is_accepted: true).order(:start_date)
    @bookings_as_bookee_rejected = Booking.where(user_booker_id: current_user).where("end_date < ?",
                                                                                     @today).where(is_accepted: false).order(:start_date)
    @bookings_pending = Booking.where(user_booker_id: current_user).where("end_date >= ?",
                                                                          @today).where(is_accepted: nil).order(:start_date)
    @bookings_active = Booking.where(user_booker_id: current_user).where("end_date >= ?",
                                                                         @today).where(is_accepted: true).order(:start_date)
    @bookings_completed = Booking.where(user_booker_id: current_user).where("end_date < ?",
                                                                            @today).where(is_accepted: true).order(:start_date)
    @bookings_rejected = Booking.where(user_booker_id: current_user).where("end_date < ?",
                                                                           @today).where(is_accepted: false).order(:start_date)
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
    if @booking.save
      redirect_to user_bookings_path(current_user), notice: "Booking successful!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def edit
    @booking = Booking.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to user_booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to user_booking_path, status: :see_other
  end

  def accepted
    @booking = Booking.find(params[:id])
    @booking.is_accepted = true
    @booking.save
    redirect_to user_bookings_path(current_user), status: :see_other
  end

  def rejected
    @booking = Booking.find(params[:id])
    @booking.is_accepted = false
    @booking.save
    redirect_to user_bookings_path(current_user), status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price, :user_bookee_id, :user_booker_id,
                                    :hours_per_day, :description, :is_accepted)
  end
end
