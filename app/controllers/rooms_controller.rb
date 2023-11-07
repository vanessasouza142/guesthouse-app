class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :check_user, only: [:new, :create, :edit, :update]

  def new
    @guesthouse = Guesthouse.find(params[:guesthouse_id])
    @room = @guesthouse.rooms.build
  end

  def create
    room_params = params.require(:room).permit(:name, :description, :area, :max_guest, :default_price, :bathroom, :balcony, :air_conditioner, 
                                                :tv, :wardrobe, :safe, :accessible)
    @guesthouse = Guesthouse.find(params[:guesthouse_id])
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

  def edit
    @room = Room.find(params[:id])
  end

  def update
    room_params = params.require(:room).permit(:name, :description, :area, :max_guest, :default_price, :bathroom, :balcony, :air_conditioner, 
                                                :tv, :wardrobe, :safe, :accessible)
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to @room, notice: 'Quarto atualizado com sucesso.'
    else
      flash.now[:notice] = 'Quarto não atualizado.'
      render 'edit'
    end
  end

  def set_available
    @room = Room.find(params[:id])
    @room.available!
    redirect_to room_path(@room.id), notice: 'Quarto disponibilizado com sucesso.'
  end

  def set_unavailable
    @room = Room.find(params[:id])
    @room.unavailable!
    redirect_to room_path(@room.id), notice: 'Quarto indisponibilizado com sucesso.'
  end

  private

  # def check_user
  #   @guesthouse = Guesthouse.find(params[:guesthouse_id])
  #   @room = @guesthouse.rooms.build
  #   if @room.guesthouse.user != current_user
  #     return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!'
  #   end
  # end

  def check_user
    if params[:id].present?
      @room = Room.find(params[:id])
        return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!' if @room.guesthouse.user != current_user
    end
    if params[:guesthouse_id].present?
      @guesthouse = Guesthouse.find(params[:guesthouse_id])
      @room = @guesthouse.rooms.build
      return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!' if @room.guesthouse.user != current_user
    end
      return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!' if current_user.guest?
  end
end
