class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
  end

  def after_sign_in_path_for(resource)
    if current_user.host?
      my_guesthouse_path
    else
      root_path
    end
  end
  
end
