class PurchasesController < ApplicationController
  before_action :correct_user ,only:[:buy, :pay]
  require "payjp"

  def buy

    @product = Product.find(params[:product_id])
    @images =  @product.images.first
    @addresses = Address.all
    if user_signed_in?
      @user = current_user
      if @user.card.present?
        Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
        @card = Card.find_by(user_id: current_user.id)
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
      else
        session["no_card"] = params[:product_id]
        redirect_to card_new_path, alert: "クレジットカードの登録をして下さい"
      end
    else
      redirect_to user_session_path, alert: "ログインしてください"
    end
  end

  def pay
    @product = Product.find(params[:product_id])
    @images = @product.images.all
    if @product.buyer_id.present?
      redirect_to product_path(@product.id), alert: "売り切れています。"
    else
      @product.with_lock do
        if current_user.card.present?
          @card = Card.find_by(user_id: current_user.id)
          Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
          charge = Payjp::Charge.create(
          amount: @product.price,
          customer: Payjp::Customer.retrieve(@card.customer_id),
          currency: 'jpy'
          )
        else
          Payjp::Charge.create(
          amount: @product.price,
          card: params['payjp-token'],
          currency: 'jpy'
          )
        end
      @product_buyer= Product.find(params[:product_id])
      @product_buyer.update( buyer_id: current_user.id)
      end
    end
  end

  private

  def correct_user
    @user = User.find(params[:id])
    @product = Product.find(params[:id])
    unless @user.id != @product.user_id
      redirect_to root_path
    end
  end
end
