class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy]

  def index
    if current_user.booker?
      @bookings = current_user.bookings
    else
      redirect_to root_path, alert: "Only listers can perform this action"
    end
  end

  def create
    @booking = current_user.bookings.new(space_id: params[:space_id])
    @space = Space.find(params[:space_id])
    if @booking.save
      @space.update(available_dates: params[:selected])
      redirect_to bookings_path, notice: 'Booking was successfully created.'
    else
      redirect_to root_path, alert: "Something went wrong. Please try again!"
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      redirect_to bookings_path, notice: 'Booking was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, notice: 'Booking was successfully destroyed.'
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:your, :list, :of, :permitted, :params)
  end
end
