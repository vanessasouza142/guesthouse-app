class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
  end

  def after_sign_in_path_for(resource)
    if current_user.host? && current_user.guesthouse.present?
      my_guesthouse_path
    elsif current_user.host? && current_user.guesthouse.nil?
      flash[:notice] = 'Você ainda não cadastrou sua pousada.'
      new_guesthouse_path
    else
      root_path
    end
  end

  def check_user(object)
    unless object.user == current_user
      redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!'
    end
  end

  # def set_guesthouse(guesthouse_id)
  #   @guesthouse = Guesthouse.find(guesthouse_id)
  # end

  # def set_guesthouse_and_check_user(guesthouse_id)
  #   @guesthouse = Guesthouse.find(guesthouse_id)
  #   if @guesthouse.user != current_user
  #     return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!'
  #   end
  # end

  def guesthouse_inactive(guesthouse_id)
    @guesthouse = Guesthouse.find(guesthouse_id)
    if @guesthouse.user != current_user && @guesthouse.inactive?
      return redirect_to root_path, alert: 'Você não tem permissão para realizar essa ação!'
    end
  end

end
