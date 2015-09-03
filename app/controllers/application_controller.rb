require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :set_locale, :set_meta
  
  after_action :store_location, :unless => :dont_store_location
  
  # https://github.com/plataformatec/devise#strong-parameters
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # dev
  before_action :sleep_a_bit
  
  
  # https://github.com/estum/growlyflash
  #use_growlyflash except: %i[actions without growlyflash]
  # Also there is another shorthand, to skip callbacks:
  # skip_growlyflash only: %i[actions without growlyflash]
  use_growlyflash
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def default_url_options(options={})
    options = options.merge({ :locale => I18n.locale })
    options.merge({ :sleep => session[:sleep] }) unless session[:sleep].blank?
  end
  
  def set_meta
    @title = "Shoppingly"
  end
  
  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end
  
  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end
  
  protected
  
  def sleep_a_bit
    if (s = params[:sleep] )
      if s.to_i > 0
        puts "**** Sleeeeeeping #{s} ****"
        sleep s.to_i
        session[:sleep] = s.to_i
      else
        session[:sleep] = 0
      end
    end
  end

  # https://github.com/plataformatec/devise#strong-parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end
  
  def store_location
    return if dont_store_location
    store_location_for(:user, request.url)
  end
  
  def dont_store_location
    @dont_store_location ||
    devise_controller? || 
    controller_name.eql?('maps') ||
    controller_name.eql?('users') && %[liked unliked likes brands].include?(action_name)
  end
    
end
