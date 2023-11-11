class CustomPricesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_custom_price_and_check_user

  def new
    @custom_price = @room.custom_prices.build
  end

  def create
    @custom_price = @room.custom_prices.build(custom_price_params)
    @custom_price.room.guesthouse.user = current_user
    if @custom_price.save
      redirect_to @room, notice: 'Preço personalizado cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Preço personalizado não cadastrado.'
      render 'new'
    end
  end

  def edit; end

  def update
    if @custom_price.update(custom_price_params)
      redirect_to @custom_price.room, notice: 'Preço personalizado atualizado com sucesso.'
    else
      flash.now[:notice] = 'Preço personalizado não atualizado.'
      render 'edit'
    end
  end

  private

  def custom_price_params
    params.require(:custom_price).permit(:begin_date, :end_date, :price)
  end

  def set_custom_price_and_check_user
    if params[:id].present?
      @custom_price = CustomPrice.find(params[:id])
      return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!' if @custom_price.room.guesthouse.user != current_user
    elsif params[:room_id].present?
      @room = Room.find(params[:room_id])
      return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!' if @room.guesthouse.user != current_user
    end
  end

  # def check_user_guest
  #   if current_user.guest?
  #     redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!'
  #   end
  # end

end