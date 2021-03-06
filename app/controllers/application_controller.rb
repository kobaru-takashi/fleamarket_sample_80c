class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_current_location, unless: :devise_controller?

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

  # def after_sign_in_path_for(resource)
  #   user_path(resource.id)
  # end
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  def set_product_search_query
    if params[:q] != nil
      params[:q]['name_or_content_cont_all'] = params[:q]['name_or_content_cont_all'].try(:split, /[\p{blank}\s]+/)
      if (params[:q]['name_or_content_cont_all'].length >=1)
        params[:q]['name_or_content_cont_all'] = params[:q]['name_or_content_cont_all'].join(" ")
        params[:q]['name_or_content_cont_all'] = params[:q]['name_or_content_cont_all'].try(:split, /[\p{blank}\s]+/)
      end
      @q = Product.ransack(params[:q])
      @products = @q.result(distinct: true).order('created_at DESC')
    else
      @q = Product.ransack(params[:q])
      @products = @q.result(distinct: true).order('created_at DESC')
    end
  end

  def birthday
    if user_signed_in?
      @user_birth = current_user
      t = Date.today
      @today = t.strftime("%m-%d")
      b = @user_birth.birth_date
      @birthday = b.strftime("%m-%d")
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, :birth_date])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
  end

  def store_current_location
    store_location_for(:user, request.url)
  end

end
