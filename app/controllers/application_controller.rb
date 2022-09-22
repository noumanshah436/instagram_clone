class ApplicationController < ActionController::Base

  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :website, :bio, :image,:image_cache])
  end

  def after_sign_in_path_for(resource)
    posts_path    # your path
  end

  # *********************************

  # for pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  private

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_back(fallback_location: root_path)
    end

end
