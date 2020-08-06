users = []
5.times do |i|
  users << User.new(name: "dummy-#{i+1}", email: "dummy-#{i+1}@dummy.com")
end

products = []
10.times do |i|
  products << Product.new(name: "dummy-#{i+1}", price: "500", content: "テスト中〜〜", condition: "1", delivery_fee: "200", send_from: "東京", delivery_date: "2", user_id: "2",category_id: "2", image_id:"2")
end

image = []
10.times do |i|
  image << Image.new(product_id: "#{i+1}", image: "pict-reason-01.jpg")
end

require "csv"

CSV.foreach('db/category.csv') do |row|
  Category.create(:id => row[0], :name => row[1], :ancestry => row[2])
end 

