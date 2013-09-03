class ApplicationController < ActionController::Base
  require 'actionpack/action_caching'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :get_categories, :apply_locale
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  before_action :expire_cache, except: [:show]
  
  # theme/dark.css
  def set_theme
    if ['dark','light'].include?(params[:theme])
      current_user.update!(:theme => params[:theme]+'.css')
    end
    expire_cache
    redirect_to :root    
  end

  # locale/ru
  def set_locale
    if ['en','ru'].include? params[:locale]
      current_user.update!(:language => params[:locale]) 
      I18n.locale = params[:locale]      
    end
    expire_cache
    redirect_to :root
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
    end

    def apply_locale
        I18n.locale = current_user.language
    end

    def books_per_page
      5
    end

    def chapters_per_page
      1
    end

    def get_categories
      @categories = ['movies','books','cartoons','comics']
    end

    def current_user
      super || guest_user
    end
  end

  private

    def guest_user
     User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = create_guest_user.id : session[:guest_user_id])
    end

    def create_guest_user
      token="#{Time.now.to_i}#{rand(99)}"
      u = User.create(:role => 'guest', :username => "guest_#{token}", :email => "guest_#{token}@example.com")
      u.save!(:validate => false)
      u
    end

    def expire_cache
      puts '!!!!!!!!!!!!!'
      expire_action :action => "show"
      expire_action :action => "index"
    end
