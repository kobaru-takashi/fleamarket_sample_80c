FactoryBot.define do

  factory :product do
    name              {Faker::JapaneseMedia::OnePiece.akuma_no_mi}
    content           {Faker::Lorem.characters(number: 100)}
    category_id          {Faker::Number.number(digits: 3)}
    send_from         {Faker::Number.between(from:1, to:47)}
    condition         {Faker::Number.between(from:1, to:6)}
    delivery_fee      {Faker::Number.between(from:1,to:2)}
    delivery_date     {Faker::Number.between(from:1, to:3)}
    brand             {Faker::Company.name}
    price             {Faker::Number.between(from:300, to:10000000)}
    saler             {FactoryBot.create(:user)}
    category

    after(:build)do |product|
      product.images << FactoryBot.build(:image,product:product)
    end
    after(:build) do |product|
      parent = create(:category, name: "親", parent_id: nil)
      child = create(:category, name: "子", parent_id: parent.id)
      grand_child = create(:category, name: "孫", parent_id: child.id)
      product.category_id = grand_child.id
    end
  end

  factory :image do
    src {Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/test_image.jpg"),'src/jpg')}
  end
end