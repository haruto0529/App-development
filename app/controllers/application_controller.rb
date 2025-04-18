class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age, :gender, :introduce, :experience_history, :prefectures])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :age, :gender, :introduce, :experience_history, :prefectures])
  end
end
