require 'open-uri'
require 'set'
require 'faker'

Faker::Config.locale = 'en'

puts "Cleaning the DB...."
Tool.destroy_all
Rental.destroy_all
User.destroy_all

puts "Creating users...."
User.create!(
    name: "admin",
    email: "admin@lewagon.com",
    password: "123456"
  )
User.create!(
  name: "renterSan",
  email: "renter@lewagon.com",
  password: "123456"
)
User.create!(
  name: "ownerSan",
  email: "owner@lewagon.com",
  password: "123456"
)


17.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "123456"
  )
end
puts "... created #{User.count} users."

puts "Creating tools...."

tool_names = [
  "Cordless Drill/Driver Kit", "Circular Saw", "Jigsaw", "Angle Grinder", "Random Orbital Sander",
  "Adjustable Wrench Set", "Screwdriver Set (Phillips & Flathead)", "Hammer (Claw)", "Tape Measure (25 ft)", "Level (24 inch)",
  "Stand Mixer", "Food Processor", "Immersion Blender", "Chef's Knife (8 inch)", "Non-stick Frying Pan (12 inch)",
  "Lawn Mower (Push)", "String Trimmer (Weed Eater)", "Leaf Blower", "Garden Shovel", "Pruning Shears"
]

tool_categories = ["power tools", "hand tools", "kitchen tools", "yard tools"]

tool_image_urls = [
  "https://images.unsplash.com/photo-1622044939413-0b829c342434?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y29yZGxlc3MlMjBkcmlsbHxlbnwwfHwwfHx8MA%3D%3D",
  "https://images.unsplash.com/photo-1617571607645-dd7dd3bf7f6b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2lyY3VsYXIlMjBzYXd8ZW58MHx8MHx8fDA%3D",
  "https://images.unsplash.com/photo-1687648347382-d33b79c30d90?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8amlnc2F3JTIwc2F3fGVufDB8fDB8fHww",
  "https://plus.unsplash.com/premium_photo-1675508139501-5312e9b51e27?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YW5nbGUlMjBncmluZGVyfGVufDB8fDB8fHww",
  "https://plus.unsplash.com/premium_photo-1681506560879-d4129fa18fb5?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c2FuZGVyfGVufDB8fDB8fHww",
  "https://plus.unsplash.com/premium_photo-1723874673961-a099a9ec566d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8d3JlbmNoJTIwc2V0fGVufDB8fDB8fHww",
  "https://images.unsplash.com/photo-1663638964085-13ee056c0a2f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8c2NyZXdkcml2ZXJ8ZW58MHx8MHx8fDA%3D",
  "https://images.unsplash.com/photo-1607870411590-d5e9e06da09a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aGFtbWVyfGVufDB8fDB8fHww",
  "https://images.unsplash.com/photo-1703756291638-b1774ae3c186?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dGFwZSUyMG1lYXN1cmV8ZW58MHx8MHx8fDA%3D",
  "https://images.unsplash.com/photo-1630419493571-5066ebfb5889?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bGV2ZWx8ZW58MHx8MHx8fDA%3D",
  "https://images.unsplash.com/photo-1595026081325-4993979442d2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c3RhbmQlMjBtaXhlcnxlbnwwfHwwfHx8MA%3D%3D",
  "https://plus.unsplash.com/premium_photo-1666649675105-1750f2bcd692?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Zm9vZCUyMHByb2Nlc3NvcnxlbnwwfHwwfHx8MA%3D%3D",
  "https://images.unsplash.com/photo-1585515320310-259814833e62?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YmxlbmRlcnxlbnwwfHwwfHx8MA%3D%3D",
  "https://images.unsplash.com/photo-1614362705324-8da11fd16754?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8a25pZmV8ZW58MHx8MHx8fDA%3D",
  "https://images.unsplash.com/photo-1464500542410-1396074bf230?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHBvdHxlbnwwfHwwfHx8MA%3D%3D",
  "https://images.unsplash.com/photo-1590820292118-e256c3ac2676?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bGF3biUyMG1vd2VyfGVufDB8fDB8fHww",
  "https://plus.unsplash.com/premium_photo-1678344184317-c373b9e91279?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8bGF3biUyMG1vd2VyfGVufDB8fDB8fHww",
  "https://images.unsplash.com/photo-1593174260957-b4eba7b3820c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bGVhZiUyMGJsb3dlcnxlbnwwfHwwfHx8MA%3D%3D",
  "https://images.unsplash.com/photo-1647978403048-2e5099133ea3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c3BhZGV8ZW58MHx8MHx8fDA%3D",
  "https://plus.unsplash.com/premium_photo-1678725713380-de0bd802d9f2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fHNoZWFyc3xlbnwwfHwwfHx8MA%3D%3D"
]

# --- HARDCODED RESIDENTIAL-STYLE TOKYO LOCATIONS ---
# These are examples of addresses in various residential or mixed-use wards.
# They are *not* specific real residential addresses of individuals.
tokyo_residential_locations = [
  "東京都世田谷区桜新町2丁目23-1",   # Sakurashinmachi, Setagaya
  "東京都杉並区高円寺南3丁目23-14",   # Koenji-Minami, Suginami
  "東京都目黒区自由が丘1丁目29-1",    # Jiyugaoka, Meguro
  "東京都練馬区練馬1丁目1-10",       # Nerima, Nerima
  "東京都大田区蒲田5丁目20-20",      # Kamata, Ota
  "東京都板橋区常盤台4丁目18-2",     # Tokiwadai, Itabashi
  "東京都足立区千住3丁目30-1",       # Senju, Adachi
  "東京都江戸川区西葛西6丁目7-1",     # Nishi-Kasai, Edogawa
  "東京都葛飾区亀有3丁目25-1",       # Kameari, Katsushika
  "東京都江東区門前仲町1丁目13-1",   # Monzen-Nakacho, Koto
  "東京都品川区大崎1丁目11-1",       # Osaki, Shinagawa
  "東京都渋谷区恵比寿1丁目8-1",      # Ebisu, Shibuya
  "東京都新宿区高田馬場1丁目25-1",   # Takadanobaba, Shinjuku
  "東京都中野区中野5丁目52-15",      # Nakano, Nakano
  "東京都豊島区南池袋1丁目28-1",     # Minami-Ikebukuro, Toshima
  "東京都文京区本郷5丁目28-1",       # Hongo, Bunkyo
  "東京都千代田区神田駿河台2丁目1",   # Kanda-Surugadai, Chiyoda
  "東京都中央区日本橋2丁目4-1",      # Nihonbashi, Chuo (more commercial, but common for apartments)
  "東京都台東区浅草橋1丁目22-1",     # Asakusabashi, Taito
  "東京都港区麻布十番2丁目3-1",      # Azabu-Juban, Minato (more upscale residential)
]

# Shuffle the locations once to assign them randomly to users
shuffled_tokyo_locations = tokyo_residential_locations.shuffle

users_with_locations = {} # To store which location is assigned to which user
User.all.each_with_index do |user, index|
  user_location = shuffled_tokyo_locations[index % shuffled_tokyo_locations.length]
  users_with_locations[user.id] = user_location
end

User.all.each do |user|
  user_assigned_location = users_with_locations[user.id]
  num_tools = rand(1..5)
  puts "Creating #{num_tools} tools for user #{user.id} at #{user_assigned_location}"

  num_tools.times do |i|
    tool_index = (user.id + i) % tool_names.length
    name = tool_names[tool_index]
    category = tool_categories[tool_index % tool_categories.length].downcase

    tool = Tool.create!(
      name: name,
      description: Faker::Lorem.paragraph(sentence_count: 3),
      condition: ["good", "fair", "excellent"].sample,
      location: user_assigned_location,
      price: rand(1000..5000),
      category: category,
      user: user
    )

    if tool_image_urls[tool_index].present?
      begin
        file = URI.open(tool_image_urls[tool_index])
        tool.photo.attach(io: file, filename: "#{name.gsub(/\s+/, '_').downcase}.jpg", content_type: "image/jpeg")
        tool.save!
        puts "  Attached photo from URL to #{name}"
      rescue OpenURI::HTTPError => e
        puts "  Error attaching photo from URL to #{name}: #{e.message}"
      rescue URI::InvalidURIError => e
        puts "  Error with URL for #{name}: #{e.message}"
      end
    else
      puts "  No image URL provided for #{name}"
    end
  end
end

puts "... finished creating tools."
puts "... created #{Tool.count} tools in total."


puts "Creating rentals...."
User.all.each do |user|
  if user.tools.any?
    available_tools = Tool.where.not(user: user).order('RANDOM()')

    if available_tools.any?
      Rental.create!(
        start_date: Faker::Date.backward(days: 3),
        end_date: Faker::Date.forward(days: 10),
        status: ["pending", "accepted", "declined"].sample,
        total_price: rand(1000..10000),
        user: user,
        tool: available_tools.first
      )
    else
      puts "  No available tools for user #{user.id} to rent from others."
    end
  else
    puts "  Skipping rental for user #{user.id} as they have no tools."
  end
end
puts "... created #{Rental.count} rentals."
