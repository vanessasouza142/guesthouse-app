class RoomsController < ApplicationController
  # before_action :authenticate_user!, only: [:edit, :update]
  before_action :check_user, only: [:new, :create] #:edit, :update]

  def new
    @guesthouse = Guesthouse.find(params[:guesthouse_id])
    @room = @guesthouse.rooms.build
  end

  def create
    room_params = params.require(:room).permit(:name, :description, :area, :max_guest, :daily_price, :bathroom, :balcony, :air_conditioner, 
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
  end

  private

  def check_user
    @guesthouse = Guesthouse.find(params[:guesthouse_id])
    @room = @guesthouse.rooms.build
    if @room.guesthouse.user != current_user
      return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!'
    end
  end
end
