class RegistrationsController < Devise::RegistrationsController
  def create
    puts "CUSTOM CONTROLLER"
    if !verify_recaptcha
      puts "RECAPTCHA FAILED"
      flash.delete :recaptcha_error
      build_resource(sign_up_params)
      resource.valid?
      resource.errors.add(:base, "There was an error with the recaptcha code below. Please re-enter the code.")
      gflash :error => "Recaptcha failed. Please resubmit your account registration."
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new }

    else
      puts "RECAPTCHA SUCCESS"
      flash.delete :recaptcha_error
      gflash :success => "Thanks for your signup"
      super
    end
  end
  # def create
  #   begin
  #     build_resource(sign_up_params)
  #
  #   rescue ActiveRecord::RecordNotUnique
  #     user = User.find_by_email(params[:user][:email])
  #     if user.present? && user.valid_password?(params[:user][:password])
  #       # The credentials are valid for the existing user. We can
  #       # sign them in.
  #       sign_in(:user, user)
  #       respond_with user, :location => after_sign_in_path_for(user)
  #     else
  #       # The credentials are invalid.
  #       # This should only happen if multiple users register with the
  #       # same email at the same time. Now we can simply attempt to
  #       # register the user again, knowing it will fail, in order to
  #       # generate the appropriate error messages.
  #       super
  #     end
  #   end
  # end

  protected
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :email_opt_in, :affiliation])
  end
    # def after_sending_reset_password_instructions_path_for(resource)
    #   root_path
    # end
end