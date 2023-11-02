class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if current_user.host?
      new_guesthouse_path
    else
      root_path
    end
  end

  def after_sign_in_path_for(resource)
    if current_user.host?
      my_guesthouse_path
    else
      root_path
    end
  end

end