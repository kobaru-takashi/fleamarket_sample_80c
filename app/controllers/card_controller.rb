class CardController < ApplicationController
  require "payjp" 
  after_action :session_clear, only: [:show]
  def new
    if current_user.card.present?
      session[:previous_url] = request.referer

      redirect_to card_index_path
    end
  end

  def create
    @session = session[:previous_url]
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)

    if params["payjp_token"].blank?
      redirect_to action: "new", alert: "クレジットカードを登録できませんでした。"
    else
      customer = Payjp::Customer.create(
        card: params["payjp_token"]
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      @session = session[:previous_url]
      if @card.save

        # @card.save ? (redirect_to request.referer) : (render :new)
      else
        redirect_to action: "create"

      end
    end
  end

  def index
    @card = Card.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @customer_card = customer.cards.retrieve(@card.card_id)
      @card_brand = @customer_card.brand
      case @card_brand
      when "Visa"
        @card_src = "visa.svg"
      when "JCB"
        @card_src = "jcb.svg"
      when "MasterCard"
        @card_src = "mastercard.svg"
      when "American Express"
        @card_src = "american_express.svg"
      when "Diners Club"
        @card_src = "dinersclub.svg"
      when "Discover"
        @card_src = "discover.svg"
      end
      @exp_month = @customer_card.exp_month.to_s
      @exp_year = @customer_card.exp_year.to_s.slice(2,3)
    end
  end

  def destroy
    @card = Card.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
      if @card.destroy
      else
        redirect_to card_path(current_user.id), alert: "削除できませんでした。"
      end
    end
  end
  def session_clear
    session[:previous_url].clear
  end
end