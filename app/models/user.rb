class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:twitter]

  validates :nickname, :email , presence: true, uniqueness: true
  validates :family_name_kana,  :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
  validates :birth_date, presence: true
  
  validates :password, presence: true, format: { with:  /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]{6,100}+\z/ }, on: :create
  

  validates :family_name, :first_name, presence: true, format:{ with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/ }

  has_one :address
  has_many :products

  # has_one :card, dependent: :destroy
  has_one :card
  has_many :sns_credentials
end
