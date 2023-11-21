class BookingsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :check_availability]
  before_action :redirect_host_to_new

  def my_bookings
    @my_bookings = current_user.bookings
  end

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
    booking_data_session = session.fetch('booking_data', {})
    @room_id = booking_data_session['room_id']
    @room_name = booking_data_session['room_name']
    @checkin_date = Date.parse(booking_data_session['checkin'])
    @checkout_date = Date.parse(booking_data_session['checkout'])
    @guests_number = booking_data_session['guests_number']
    @total_price = booking_data_session['total_price']
    @room = Room.find(@room_id)
    @guesthouse = @room.guesthouse
  end

  def create
    booking_data_session = session.fetch('booking_data', {})
    @room_id = booking_data_session['room_id']
    @room_name = booking_data_session['room_name']
    @checkin_date = Date.parse(booking_data_session['checkin'])
    @checkout_date = Date.parse(booking_data_session['checkout'])
    @guests_number = booking_data_session['guests_number']
    @total_price = booking_data_session['total_price']

    @booking = Booking.create!(room_id: @room_id, user_id: current_user.id, check_in_date: @checkin_date, check_out_date: @checkout_date, 
                              guests_number: @guests_number) 
    @booking.user = current_user
    if @booking.save
      session.delete('booking_data')
      redirect_to my_bookings_path, notice: 'Reserva realizada com sucesso.'
    else
      redirect_to room_path(@room_id), notice: 'Reserva não realizada.'
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def set_in_progress
    @booking = Booking.find(params[:id])
    if @booking.allow_check_in
      redirect_to booking_path(@booking), notice: 'Check-in realizado com sucesso.'
    else
      redirect_to booking_path(@booking), alert: 'Ainda não é possível realizar o check-in dessa reserva.'
    end
  end

  def set_finished
    @booking = Booking.find(params[:id])
    @booking.finished!
    @booking.update(check_out_done: Time.current)
    redirect_to payment_booking_path(@booking)
  end

  def payment
    @booking = Booking.find(params[:id])
    @payment_amount = @booking.calculate_payment_amount
    if @booking.check_out_done.strftime('%H:%M') > @booking.room.guesthouse.check_out.strftime('%H:%M')
      flash[:notice] = 'Check-out realizado com sucesso mas depois do horário previsto, portanto será cobrada mais uma diária.'
    else
      flash[:notice] = 'Check-out realizado com sucesso dentro do horário previsto.'
    end
  end

  def register_payment
    @booking = Booking.find(params[:id])
    @booking.register_payment_context = true
    payment_params = params.require(:booking).permit(:payment_amount, :payment_method)  
    if @booking.update(payment_params)
      redirect_to my_guesthouse_path, notice: 'Pagamento registrado com sucesso.'
    else
      flash.now[:notice] = 'Pagamento não registrado.'
      render 'payment'
    end
  end

  def cancel
    @booking = Booking.find(params[:id])
    if Date.today >= (@booking.check_in_date + 2)
      @booking.destroy
      redirect_to bookings_guesthouse_path(current_user.guesthouse), notice: 'Reserva cancelada com sucesso.'
    else
      redirect_to booking_path(@booking), alert: 'Só é possível cancelar a reserva após 2 dias da data prevista para o check-in.'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:check_in_date, :check_out_date, :guests_number)
  end

end