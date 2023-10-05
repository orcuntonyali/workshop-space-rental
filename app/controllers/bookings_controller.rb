class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

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
      @space.update(availability: false)
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
    @booking.destroy
    redirect_to bookings_path, notice: 'Booking was successfully deleted.'
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:your, :list, :of, :permitted, :params)
  end
end

# def create
#   return unless current_user&.booker?

#   @booking = Booking.new
#   @booking.user = current_user
#   @booking.space_id = params[:space_id]

#   if @booking.save
#     @space = @booking.space
#     @space.update_attribute(:availability, false) if @space
#     redirect_to bookings_path, notice: "Booking was successfully created."
#   else
#     render :new
#   end
