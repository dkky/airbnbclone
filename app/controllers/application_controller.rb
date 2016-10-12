class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters

    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    user_params.permit(:user_type, :first_name, :last_name, :spouse_first_name, :avatar, {photos: []}, :family_description, :encrypted_password, :email, :password, children_attributes: [:id,:first_name,:date_of_birth])
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
    user_params.permit(:user_type, :first_name, :last_name, :spouse_first_name, :avatar, {photos: []}, :family_description, :encrypted_password, :email, :password, :current_password, children_attributes: [:id,:first_name,:date_of_birth])
    end

   
  end

end
