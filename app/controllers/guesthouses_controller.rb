class GuesthousesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :check_user, except: [:my_guesthouse, :show]

  def my_guesthouse
    @guesthouse = current_user.guesthouse
  end

  def new
    if current_user.host? && current_user.guesthouse.present?
      redirect_to my_guesthouse_path, alert: 'Só é possível ter uma pousada cadastrada por usuário!'
    else
      @guesthouse = Guesthouse.new
    end
  end

  def create
    guesthouse_params = params.require(:guesthouse).permit(:corporate_name, :brand_name, :registration_number, :phone_number, :email,
                                                            :address, :neighborhood, :state, :city, :postal_code, :description, 
                                                            :payment_method, :pet_agreement, :usage_policy, :check_in, :check_out)
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

  def edit
    @guesthouse = Guesthouse.find(params[:id])
  end

  def update
    guesthouse_params = params.require(:guesthouse).permit(:corporate_name, :brand_name, :registration_number, :phone_number, :email,
                                                            :address, :neighborhood, :state, :city, :postal_code, :description, 
                                                            :payment_method, :pet_agreement, :usage_policy, :check_in, :check_out)
    @guesthouse = Guesthouse.find(params[:id])
    if @guesthouse.update(guesthouse_params)
      redirect_to @guesthouse, notice: 'Pousada atualizada com sucesso.'
    else
      flash.now[:notice] = 'Pousada não atualizada.'
      render 'edit'
    end
  end

  def activate
    @guesthouse = Guesthouse.find(params[:id])
    @guesthouse.active!
    redirect_to guesthouse_path(@guesthouse.id), notice: 'Pousada ativada com sucesso.'
  end

  def inactivate
    @guesthouse = Guesthouse.find(params[:id])
    @guesthouse.inactive!
    redirect_to guesthouse_path(@guesthouse.id), notice: 'Pousada desativada com sucesso.'
  end

  # def search_by_city
  #   city_name = params[:city]
  #   @guesthouses_in_city = Guesthouse.where(city: city_name)
  # end

  private

  def check_user
    if params[:id].present?
      @guesthouse = Guesthouse.find(params[:id])
        return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!' if @guesthouse.user != current_user
    end
      return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!' if current_user.guest?
  end

end