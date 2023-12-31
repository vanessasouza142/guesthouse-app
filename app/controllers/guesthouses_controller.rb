class GuesthousesController < ApplicationController
  before_action :authenticate_user!, only: [:my_guesthouse, :new, :create, :edit, :update, :activate, :inactivate, 
                                            :bookings, :active_stays, :reviews]  
  before_action :redirect_host_to_new, only: [:my_guesthouse, :show, :edit, :update, :activate, :inactivate, :search, 
                                              :by_city, :bookings, :active_stays, :reviews, :all_reviews] 
  before_action :allow_only_host, only: [:new, :create]
  before_action :check_guesthouse_presence, only: [:new, :create]
  before_action only: [:edit, :update, :activate, :inactivate] do
    @guesthouse = Guesthouse.find(params[:id])
    check_user(@guesthouse)
  end
  before_action :guesthouse_inactive, only: [:show, :all_reviews]

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
    if @guesthouse.user == current_user
      @rooms = @guesthouse.rooms.order(:name)
    else
      @rooms = @guesthouse.rooms.available.order(:name)
    end
    @last_reviews = @guesthouse.reviews.last(3)
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
    @guesthouses = Guesthouse.search(@query)
  end

  def by_city
    @city = params[:city]
    @guesthouses_by_city = Guesthouse.where(city: @city).active.order(:brand_name)
  end

  def bookings
    @guesthouse = current_user.guesthouse
    @bookings = @guesthouse.bookings.pending.order(check_in_date: :asc)
  end
  
  def active_stays
    @guesthouse = current_user.guesthouse
    @in_progress_bookings = @guesthouse.bookings.in_progress.order(check_in_date: :asc)
  end

  def reviews
    @guesthouse = current_user.guesthouse
    @reviews = @guesthouse.reviews
  end

  def all_reviews
    @all_reviews = @guesthouse.reviews
  end

  private

  def guesthouse_params
    params.require(:guesthouse).permit(:corporate_name, :brand_name, :registration_number, :phone_number, :email, :address, :neighborhood, 
                                        :state, :city, :postal_code, :description, :payment_method, :pet_agreement, :usage_policy, 
                                        :check_in, :check_out)
  end

  def check_guesthouse_presence
    if current_user.guesthouse.present?
      redirect_to my_guesthouse_path, alert: 'Só é possível ter uma pousada cadastrada por usuário!'
    end
  end

end