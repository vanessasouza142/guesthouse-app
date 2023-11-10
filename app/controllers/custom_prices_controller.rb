class CustomPricesController < ApplicationController
  before_action :authenticate_user!
  # before_action :check_user

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

  def edit
    @custom_price = CustomPrice.find(params[:id])
  end

  def update
    custom_price_params = params.require(:custom_price).permit(:begin_date, :end_date, :price)
    @custom_price = CustomPrice.find(params[:id])
    if @custom_price.update(custom_price_params)
      redirect_to @custom_price.room, notice: 'Preço personalizado atualizado com sucesso.'
    else
      flash.now[:notice] = 'Preço personalizado não atualizado.'
      render 'edit'
    end
  end

  private

  # def check_user
  #   if params[:id].present?
  #     @custom_price = CustomPrice.find(params[:id])
  #     return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!' if @custom_price.room.guesthouse.user = current_user
  #   end
  #   if params[:room_id].present?
  #     @room = Room.find(params[:room_id])
  #     @custom_price = @room.custom_prices.build
  #     return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!' if @custom_price.room.guesthouse.user = current_user
  #   end
  #     return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!' if current_user.guest?
  # end

end