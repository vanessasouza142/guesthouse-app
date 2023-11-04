class GuesthousesController < ApplicationController
  before_action :authenticate_user!, only: [:my_guesthouse, :new, :create, :edit, :update]
  before_action :check_user, only: [:new, :create, :edit, :update]

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

  private

  def check_user
    if params[:id].present?
      @guesthouse = Guesthouse.find(params[:id])
        return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!' if @guesthouse.user != current_user
    end
      return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!' if current_user.guest?
  end

end