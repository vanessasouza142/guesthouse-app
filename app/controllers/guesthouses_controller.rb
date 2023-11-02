class GuesthousesController < ApplicationController
  before_action :authenticate_user!, only: [:my_guesthouse, :new, :create, :edit, :update]
  before_action :only_host_permit, only: [:new, :create, :edit, :update]
  before_action :set_guesthouse_and_check_user, only: [:edit, :update]

  def my_guesthouse
    @guesthouse = current_user.guesthouse
  end

  def new
    @guesthouse = Guesthouse.new
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

    def only_host_permit
      if current_user.guest?
        return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!'
      end
    end

  def set_guesthouse_and_check_user
    @guesthouse = Guesthouse.find(params[:id])
    if @guesthouse.user != current_user
      return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!'
    end
  end

end