5.times do |i|
  nickname = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  User.create!(nickname: nickname,
               email: email,
               password: password,
               password_confirmation: password,
               )
end

10.times do |i|
  Product.create!(name: "dummy-#{i+1}", price: "500", content: "テスト文面", condition: "1", delivery_fee: "200", send_from: "東京", delivery_date: "2", user_id: "2",category_id: "2", brand: "テックキャンプ ")
end


10.times do |i|
  Image.create!(product_id: "#{i+1}", src: "pict-reason-01.jpg")
end

require "csv"

CSV.foreach('db/category.csv') do |row|
  Category.create(:id => row[0], :name => row[1], :ancestry => row[2])
end
