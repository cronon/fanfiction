class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :get_categories, :apply_locale

  def apply_locale
    unless current_user.nil?
      I18n.locale = current_user.language
    else
      I18n.locale = I18n.default_locale
    end
  end

 #  def current_ability
 #    @current_ability ||= Ability.new(current_user)
  # end

  # theme/dark.css
  def set_theme
    if ['dark','light'].include?(params[:theme])
      current_user.theme = params[:theme]+'.css'
      current_user.save
    end
    redirect_to :back
  end

  # locale/ru
  def set_locale
    if ['en','ru'].include? params[:locale]
      current_user.language = params[:locale] 
      current_user.save    
      puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
      puts current_user.language
      I18n.locale = params[:locale] || I18n.default_locale
      puts I18n.locale
      redirect_to :back
    end
  end

  def books_per_page
    10
  end

  def chapters_per_page
    1
  end

  def get_categories
    @categories = ['Movies','Books','Cartoons','Comics']
  end

  

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
    end

end
