require 'open-uri'
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
19.times do
  # inside of the seeds, you can use Pet.create! to stop the seeds if it fails
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "123456"
  )
end
puts "... created #{User.count} users."

puts "Creating tools...."
User.all.each do |user|
  # inside of the seeds, you can use Pet.create! to stop the seeds if it fails
  Tool.create!(
    name: Faker::Games::Minecraft.item,
    description: "At vero eos et accusamus et iusto odio dignissimos ducimus, qui blanditiis praesentium voluptatum deleniti atque corrupti, quos dolores et quas molestias excepturi sint, obcaecati cupiditate non provident, similique sunt in culpa, qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem reru[d]um facilis est e[r]t expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi o",
    condition: "good",
    location: Faker::Address.city,
    rental_price: 3000,
    category: Faker::Hobby.activity,
    user: user
  )
end
puts "... created #{Tool.count} tools."


puts "Creating rentals...."
User.all.each do |user|
  # inside of the seeds, you can use Pet.create! to stop the seeds if it fails
  Rental.create!(
    start_date: Faker::Date.backward(days: 3),
    end_date: Faker::Date.forward(days: 10),
    rental_status: "pending",
    total_price: 3000,
    user: user,
    tool: Tool.where.not(user: user).sample
  )
end
puts "... created #{Rental.count} rentals."
