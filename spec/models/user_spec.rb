require 'rails_helper'

describe User do
  describe '#create' do

    it "is valid with a nickname, email, password, password_confirmation, family_name, first_name, family_name_kana, first_name_kana, birth_date" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "is invalid without an email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "is invalid without a family_name" do
      user = build(:user, family_name: "")
      user.valid?
      expect(user.errors[:family_name]).to include("can't be blank")
    end

    it "is invalid without a first_name" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "is invalid without a family_name_kana" do
      user = build(:user, family_name_kana: "")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("can't be blank")
    end

    it "is invalid without a first_name_kana" do
      user = build(:user, first_name_kana: "")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end

    it "is invalid without a birth_date" do
      user = build(:user, birth_date: "")
      user.valid?
      expect(user.errors[:birth_date]).to include("can't be blank")
    end

    it "is invalid with a duplicate nickname" do
      user = create(:user)
      another_user = build(:user, nickname: user.nickname)
      another_user.valid?
      expect(another_user.errors[:nickname]).to include("has already been taken")
    end

    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    it "is valid with a password that has more than 6 characters " do
      user = build(:user, password: "000aaa", password_confirmation: "000aaa")
      expect(user).to be_valid
    end

    it "is invalid with a password that has less than 5 characters " do
      user = build(:user, password: "000aa", password_confirmation: "00aa")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it "is invalid with a pssword without number" do
      user = build(:user, password: "aaaaaa", password_confirmation: "aaaaaa")
      user.valid?
      expect(user.errors[:password]).to include("is invalid")
    end

    it "is invalid with a pssword without character" do
      user = build(:user, password: "123456", password_confirmation: "123456")
      user.valid?
      expect(user.errors[:password]).to include("is invalid")
    end

    it "is valid with a password that is include character and number" do
      user = build(:user, password: "abc123", password_confirmation: "abc123")
      expect(user).to be_valid
    end

    it "is invalid with a family_name that is small character" do
      user = build(:user, family_name: "hoge")
      user.valid?
      expect(user.errors[:family_name]).to include("is invalid")
    end

    it "is invalid with a first_name that is small character" do
      user = build(:user, first_name: "hoge")
      user.valid?
      expect(user.errors[:first_name]).to include("is invalid")
    end

    it "is invalid that a first_name_kana is not katakana" do
      user = build(:user, family_name_kana: "hoge")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("is invalid")
    end

    it "is invalid that a first_name_kana is not katakana" do
      user = build(:user, first_name_kana: "hoge")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("is invalid")
    end

  end
end