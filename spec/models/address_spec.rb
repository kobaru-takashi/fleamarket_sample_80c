require 'rails_helper'

describe Address do
  describe '#create' do

    it "is valid with family_name, first_name, family_name_kana, first_name_kana, post_code, prefecture, city, address" do
      address = build(:address)
      expect(address).to be_valid
    end

    it "is invalid without a family_name" do
      address = build(:address, family_name: "")
      address.valid?
      expect(address.errors[:family_name]).to include("can't be blank")
    end

    it "is invalid without a first_name" do
      address = build(:address, first_name: "")
      address.valid?
      expect(address.errors[:first_name]).to include("can't be blank")
    end

    it "is invalid without a family_name_kana" do
      address = build(:address, family_name_kana: "")
      address.valid?
      expect(address.errors[:family_name_kana]).to include("can't be blank")
    end

    it "is invalid without a first_name_kana" do
      address = build(:address, first_name_kana: "")
      address.valid?
      expect(address.errors[:first_name_kana]).to include("can't be blank")
    end

    it "is invalid with a family_name that is small character" do
      address = build(:address, family_name: "hoge")
      address.valid?
      expect(address.errors[:family_name]).to include("is invalid")
    end

    it "is invalid with a first_name that is small character" do
      address = build(:address, first_name: "hoge")
      address.valid?
      expect(address.errors[:first_name]).to include("is invalid")
    end

    it "is invalid that a first_name_kana is not katakana" do
      address = build(:address, family_name_kana: "hoge")
      address.valid?
      expect(address.errors[:family_name_kana]).to include("is invalid")
    end

    it "is invalid that a first_name_kana is not katakana" do
      address = build(:address, first_name_kana: "hoge")
      address.valid?
      expect(address.errors[:first_name_kana]).to include("is invalid")
    end

    it "is invalid that post_code is more than 8 characters" do
      address = build(:address, post_code: "1234-5678")
      address.valid?
      expect(address.errors[:post_code]).to include("is invalid")
    end

    it "is invalid without prefecture" do
      address = build(:address, prefecture: "")
      address.valid?
      expect(address.errors[:prefecture]).to include("can't be blank")
    end

    it "is invalid without city" do
      address = build(:address, city: "")
      address.valid?
      expect(address.errors[:city]).to include("can't be blank")
    end

    it "is invalid without address" do
      address = build(:address, address: "")
      address.valid?
      expect(address.errors[:address]).to include("can't be blank")
    end

    it "is invalid without post_code" do
      address = build(:address, post_code: "")
      address.valid?
      expect(address.errors[:post_code]).to include("can't be blank")
    end

    it "is valid without building" do
      address = build(:address, building: "")
      expect(address).to be_valid
    end

    it "is valid without telephone_number" do
      address = build(:address, telephone_number: "")
      expect(address).to be_valid
    end

  end
end