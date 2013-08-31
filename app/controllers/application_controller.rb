class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :get_categories

 #  def current_ability
 #    @current_ability ||= Ability.new(current_user)
  # end

  # theme/dark.css
  def set_theme
    if ['dark','light'].include?(params[:theme])
      current_user.theme = params[:theme]+'.css'
      current_user.save
    end
    redirect_to root_path
  end

  def items_per_page
    @items_per_page=10
  end

  def get_categories
    @categories = ['Movies','Books','Cartoons','Comics']
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
  end

end
