class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_room_and_check_user, except: [:show]

  def new
    @room = @guesthouse.rooms.build
  end

  def create
    @room = @guesthouse.rooms.build(room_params)
    @room.guesthouse.user = current_user
    if @room.save
      redirect_to @room, notice: 'Quarto cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Quarto não cadastrado.'
      render 'new'
    end
  end

  def show
    @room = Room.find(params[:id])
    @custom_prices = @room.custom_prices
  end

  def edit; end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: 'Quarto atualizado com sucesso.'
    else
      flash.now[:notice] = 'Quarto não atualizado.'
      render 'edit'
    end
  end

  def set_available
    @room.available!
    redirect_to room_path(@room.id), notice: 'Quarto disponibilizado com sucesso.'
  end

  def set_unavailable
    @room.unavailable!
    redirect_to room_path(@room.id), notice: 'Quarto indisponibilizado com sucesso.'
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :area, :max_guest, :default_price, :bathroom, :balcony, :air_conditioner, 
                                  :tv, :wardrobe, :safe, :accessible)
  end

  def set_room_and_check_user
    if params[:id].present?
      @room = Room.find(params[:id])    
      return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!' if @room.guesthouse.user != current_user
    elsif params[:guesthouse_id].present?
      @guesthouse = Guesthouse.find(params[:guesthouse_id])      
      redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!' if @guesthouse.user != current_user
    end
  end

  # def check_user_guest
  #   if current_user.guest?
  #     redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!'
  #   end
  # end
end
