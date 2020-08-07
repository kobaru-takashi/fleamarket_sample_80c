class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, uniqueness: true
  validates :family_name_kana,  :first_name_kana, presence: true,
                               format: {
                                with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
                                message: "全角カタカナのみで入力して下さい"
                               }
  validates :family_name, :first_name, :birth_date, presence: true

  has_one :address
  has_many :products
end
