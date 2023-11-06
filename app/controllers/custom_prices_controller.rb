class CustomPricesController < ApplicationController

  def new
    @room = Room.find(params[:room_id])
    @custom_price = @room.custom_prices.build
  end

  def create
    custom_price_params = params.require(:custom_price).permit(:begin_date, :end_date, :price)
    @room = Room.find(params[:room_id])
    @custom_price = @room.custom_prices.build(custom_price_params)
    @custom_price.room.guesthouse.user = current_user
    if @custom_price.save
      redirect_to @room, notice: 'Preço personalizado cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Preço personalizado não cadastrado.'
      render 'new'
    end
  end

  # def show
  #   @custom_price
  # end
end