class Api::V1::BookingsController < Api::V1::ApiController

  def check_availability
    room = Room.find(params[:room_id])
    booking_params = params.require(:booking).permit(:check_in_date, :check_out_date, :guests_number)
    booking = room.bookings.build(booking_params)
    if booking.valid?
      total_price = booking.calculate_total_price
      booking_json = booking.as_json(only: [:total_price])
      booking_json["total_price"] = total_price
      render status: 200, json: booking_json
    else
      render status: 412, json: { errors: booking.errors.full_messages }
    end
  end

end