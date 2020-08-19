class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

  def after_sign_in_path_for(resource)
    user_path(resource.id)
  end

  def set_product_search_query
    if params[:q] != nil
      params[:q]['name_or_content_cont_any'] = params[:q]['name_or_content_cont_any'].try(:split,/[\p{blank}\s]+/)
      @q = Product.ransack(params[:q])
      @products = @q.result
    else
      @q = Product.ransack(params[:q])
      @products = @q.result
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, :birth_date])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])

  end

end
