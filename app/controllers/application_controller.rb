class ApplicationController < ActionController::Base

    before_action :configure_permitted_parameters, if: :devise_controller?

  # before_action :authenticate_customer!

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      root_path
    end
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:is_deleted, :last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :postal_code, :address])
  end




end
