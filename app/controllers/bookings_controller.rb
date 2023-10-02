class BookingsController < ApplicationController
  def index
    @bookings = current_user.bookings
  end

  def create
    @booking = Booking.new
    @booking.user = current_user
    @booking.space_id = params[:space_id]

    if @booking.save
      @space = @booking.space
      @space.update_attribute(:availability, false) if @space
      redirect_to bookings_path, notice: "Booking was successfully created."
    else
      render :new
    end
  end
end
