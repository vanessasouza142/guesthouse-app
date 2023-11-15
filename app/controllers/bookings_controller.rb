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
      render 'show_availability'
    else
      render 'new'
    end
  end

  def create
    @room = Room.find(params[:room_id])
    @booking = @room.bookings.build(booking_params)

    if @booking.save
      flash[:success] = 'Reserva criada com sucesso!'
      redirect_to room_path(@room)
    else
      render 'new'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:check_in_date, :check_out_date, :guests_number)
  end

  def room_available?(check_in_date, check_out_date)
    @room = Room.find(params[:room_id])
    @booking = @room.bookings.build(booking_params)
    if @room.present? && @room.bookings.where.not(id: id).where('(check_in_date, check_out_date) OVERLAPS (?, ?)', 
      check_in_date, check_out_date).exists?
      errors.add(:base, 'O quarto não está disponível para o período selecionado.')
    end
  end



  # def create
  #   booking_params = params.require(:booking).permit(:check_in_date, :check_out_date, :guests_number)
  #   @booking = @room.bookings.build(booking_params)

  # end
end