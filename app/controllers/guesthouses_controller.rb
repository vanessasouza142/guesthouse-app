class GuesthousesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :search, :by_city]
  before_action :set_guesthouse_and_check_user, only: [:edit, :update, :activate, :inactivate]
  before_action :check_guesthouse_presence, only: [:new, :create]

  def my_guesthouse
    @guesthouse = current_user.guesthouse
  end

  def new
    @guesthouse = Guesthouse.new
  end

  def create
    @guesthouse = Guesthouse.new(guesthouse_params)
    @guesthouse.user = current_user
    if @guesthouse.save
      redirect_to @guesthouse, notice: 'Pousada cadastrada com sucesso.'
    else
      flash.now[:notice] = 'Pousada não cadastrada.'
      render 'new'
    end
  end

  def show
    @guesthouse = Guesthouse.find(params[:id])
    if current_user.present? && current_user == @guesthouse.user
      @rooms = @guesthouse.rooms.order(:name)
    else
      @rooms = @guesthouse.rooms.available.order(:name)
    end
  end

  def edit; end

  def update
    if @guesthouse.update(guesthouse_params)
      redirect_to @guesthouse, notice: 'Pousada atualizada com sucesso.'
    else
      flash.now[:notice] = 'Pousada não atualizada.'
      render 'edit'
    end
  end

  def activate
    @guesthouse.active!
    redirect_to guesthouse_path(@guesthouse.id), notice: 'Pousada ativada com sucesso.'
  end

  def inactivate
    @guesthouse.inactive!
    redirect_to guesthouse_path(@guesthouse.id), notice: 'Pousada desativada com sucesso.'
  end

  def search
    @query = params["query"]
    @guesthouses = Guesthouse.where("brand_name LIKE ? OR neighborhood LIKE ? OR city LIKE ?", "%#{@query}%", "%#{@query}%", 
                                    "%#{@query}%").active.order(:brand_name)
  end

  def by_city
    @city = params[:city]
    @guesthouses_by_city = Guesthouse.where(city: @city).active.order(:brand_name)
  end

  private

  def guesthouse_params
    params.require(:guesthouse).permit(:corporate_name, :brand_name, :registration_number, :phone_number, :email, :address, :neighborhood, 
                                        :state, :city, :postal_code, :description, :payment_method, :pet_agreement, :usage_policy, 
                                        :check_in, :check_out)
  end

  def set_guesthouse_and_check_user
    @guesthouse = Guesthouse.find(params[:id])
    if @guesthouse.user != current_user
      return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!'
    end
  end

  def check_guesthouse_presence
    if current_user.guesthouse.present?
      redirect_to my_guesthouse_path, alert: 'Só é possível ter uma pousada cadastrada por usuário!'
    end
  end

  # def check_user_guest
  #   if current_user.guest?
  #     redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!'
  #   end
  # end
end