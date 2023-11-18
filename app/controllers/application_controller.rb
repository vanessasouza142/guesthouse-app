class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :cpf])
  end

  def after_sign_in_path_for(resource)
    if current_user.host? && current_user.guesthouse.present?
      my_guesthouse_path
    elsif current_user.present? && current_user.host? && current_user.guesthouse.nil?
      flash[:notice] = 'Você ainda não cadastrou sua pousada.'
      new_guesthouse_path
    elsif current_user.guest? && !session['booking_data'].nil?
      confirm_booking_path
    else
      root_path
    end
  end

  def redirect_host_to_new
    if current_user.present? && current_user.host? && current_user.guesthouse.nil?
      flash[:notice] = 'Você ainda não cadastrou sua pousada.'
      return redirect_to new_guesthouse_path
    end
  end

  def check_user(object)
    unless object.user == current_user
      return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!'
    end
  end

  def guesthouse_inactive
    @guesthouse = Guesthouse.find(params[:id])
    if @guesthouse.user != current_user && @guesthouse.inactive?
      return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!'
    end
  end

  def room_unavailable
    @room = Room.find(params[:id])
    if @room.guesthouse.user != current_user && @room.unavailable?
      return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!'
    end
  end

end
