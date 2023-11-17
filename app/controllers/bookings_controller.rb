class BookingsController < ApplicationController
  before_action :redirect_host_to_new

  def new
    @room = Room.find(params[:room_id])
    @booking = @room.bookings.build
  end

  def check_availability
    @room = Room.find(params[:room_id])
    @booking = @room.bookings.build(booking_params)

    if @booking.valid?
      @total_price = @booking.calculate_total_price
      session['booking_data'] = {room_id: @room.id, room_name: @room.name, checkin: @booking.check_in_date, 
                                  checkout: @booking.check_out_date, guests_number: @booking.guests_number, total_price: @total_price}
      render 'show_availability'
    else
      render 'new'
    end
  end

  def confirm_booking
    booking_data_session = session['booking_data']
    if booking_data_session.present?
      @room_id = booking_data_session['room_id']
      @room_name = booking_data_session['room_name']
      @checkin_date = Date.parse(booking_data_session['checkin'])
      @checkout_date = Date.parse(booking_data_session['checkout'])
      @guests_number = booking_data_session['guests_number']
      @total_price = booking_data_session['total_price']
    else
      redirect_to room(@room_id), notice: 'Não foi posível prosseguir com sua reserva.'
    end
    @room = Room.find(@room_id)
    @guesthouse = @room.guesthouse
  end

  def create
    booking_data_session = session['booking_data']
    if booking_data_session.present?
      @room_id = booking_data_session['room_id']
      @room_name = booking_data_session['room_name']
      @checkin_date = Date.parse(booking_data_session['checkin'])
      @checkout_date = Date.parse(booking_data_session['checkout'])
      @guests_number = booking_data_session['guests_number']
      @total_price = booking_data_session['total_price']
    else
      redirect_to room(@room_id), notice: 'Não foi posível prosseguir com sua reserva.'
    end

    @booking = Booking.create!(room_id: @room_id, user_id: current_user.id, check_in_date: @checkin_date, check_out_date: @checkout_date, 
                              guests_number: @guests_number)
    if @booking.save
      reset_session
      redirect_to root_path, notice: 'Reserva cadastrada com sucesso.'
    else
      flash.now[:notice] = 'Reserva não cadastrada.'
      # render 'new'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:check_in_date, :check_out_date, :guests_number)
  end

end