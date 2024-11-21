# Fill the DB with some instances we can use
puts "Cleaning the DB..."
Restaurant.destroy_all
User.destroy_all

CHEFS = %w[Adam Arisa Bart Brian Chafique Christian Claudia Denis Dylan Esteban Henry Jarod Loris Mark Mason PhyuPhyu Roman Steven Stuart Toby Tristan Will]
CATEGORIES = %W[burger ramen sushi desserts healthy kebabs pizza tacos sandwiches dumplings soup curry rice pasta steakhouse vegan bakery juice salads seafood brunch wings cafe bbq deli pies buffet pub brasserie shakes creamery grill]

noemi = User.create!(email: "noemi@email.com", password: "123456", username: "noemi-ashizuka")
doug = User.create!(email: "doug@email.com", password: "123456", username: "dmbf29")
trouni = User.create!(email: "trouni@email.com", password: "123456", username: "trouni")
yann = User.create!(email: "yann@email.com", password: "123456", username: "yannklein")


def get_category(name)
  last_word = name.split.last.downcase
  CATEGORIES.include?(last_word) ? last_word : CATEGORIES.sample
end


puts "Creating some Restaurants..."
CHEFS.shuffle.each do |name|
  user = User.create!(email: "#{name.downcase}@lewagon.com", password: '123123', username: name)

  restaurant_name = Faker::Restaurant.unique.name
  Restaurant.create!(
    name: "#{name}'s #{restaurant_name}",
    rating: rand(3..5),
    address: "日本, 〒153-0063 東京都目黒区 目黒#{rand(1..3)}丁目#{rand(1..10)}番#{rand(1..3)}号",
    category: get_category(restaurant_name),
    chef_name: name,
    opening_date: Date.today - rand(10..50),
    user: [noemi, doug, trouni, yann].sample
  )
end

puts "... created #{Restaurant.count} restaurants"
