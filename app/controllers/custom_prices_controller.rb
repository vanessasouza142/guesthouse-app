class CustomPricesController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_host_to_new
  before_action only: [:new, :create] do
    @room = Room.find(params[:room_id])
    check_user(@room.guesthouse)
  end
  before_action only: [:edit, :update] do
    @custom_price = CustomPrice.find(params[:id])
    check_user(@custom_price.room.guesthouse)
  end

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

  # def check_user_guest
  #   if current_user.guest?
  #     redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!'
  #   end
  # end

end