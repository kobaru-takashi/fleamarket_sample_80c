require 'rails_helper'

describe Product do
  describe '#create' do

    it "is valid with name,content,category_id, send_from, delivery_fee, delivery_date, condition, brand, price, user_id, saler_id, image" do
      product = build(:product)
      expect(product).to be_valid
    end

    it "is vslid without brand" do
      product = build(:product, brand:"")
      expect(product).to be_valid
    end

    it "is invalid without name" do
      product = build(:product, name:"")
      product.valid?
      expect(product.errors[:name]).to include("can't be blank")
    end

    it "is invalid without content" do
      product = build(:product, content:"")
      product.valid?
      expect(product.errors[:content]).to include("can't be blank")
    end

    it "is invalid without condition" do
      product = build(:product, condition:"")
      product.valid?
      expect(product.errors[:condition]).to include("can't be blank")
    end

    it "is invalid without send_from" do
      product = build(:product, send_from:"")
      product.valid?
      expect(product.errors[:send_from]).to include("can't be blank")
    end

    it "is invalid without delivery_fee" do
      product = build(:product, delivery_fee:"")
      product.valid?
      expect(product.errors[:delivery_fee]).to include("can't be blank")
    end

    it "is invalid without delivery_date" do
      product = build(:product, delivery_date:"")
      product.valid?
      expect(product.errors[:delivery_date]).to include("can't be blank")
    end

    it "is invalid without price" do
      product = build(:product, price:"")
      product.valid?
      expect(product.errors[:price]).to include("can't be blank")
    end

    it "is invalid without saler" do
      product = build(:product, saler_id:"")
      product.valid?
      expect(product.errors[:saler]).to include("must exist")
    end

    it "is invalid that price is more than ¥10000000" do
      product = build(:product, price:"10000001")
      product.valid?
      expect(product.errors[:price]).to include("must be less than 10000000")
    end

    it "is invalid that price is less than ¥300" do
      product = build(:product, price:"299")
      product.valid?
      expect(product.errors[:price]).to include("must be greater than 300")
    end

    it "is invalid that price is not integer" do
      product = build(:product, price:"千円")
      product.valid?
      expect(product.errors[:price]).to include("is not a number")
    end

    it "is invalid with name that is more than 40 chracters" do
      product = build(:product, name: Faker::Lorem.characters(number: 41))
      product.valid?
      expect(product.errors[:name]).to include("is too long (maximum is 40 characters)")
    end

    it "is invalid that content is more than 1000 characters" do
      product = build(:product, content: Faker::Lorem.characters(number: 1001))
      product.valid?
      expect(product.errors[:content]).to include("is too long (maximum is 1000 characters)")
    end

    it 'is invalid without images' do
      product = build(:product)
      image =build(:image, src:"")
      product.valid?
      expect(product.errors[:image]).to include("is invalid")
    end

  end
end