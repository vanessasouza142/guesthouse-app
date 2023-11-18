class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if current_user.host? && current_user.guesthouse.nil?
      new_guesthouse_path
    elsif current_user.guest? && !session['booking_data'].nil?
      confirm_booking_path
    else
      root_path
    end
  end

end