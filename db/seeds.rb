# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create a few users
users = 5.times.map do
  User.create!(
    email: Faker::Internet.unique.email,
    password: '123456'
  )
end

# Create spaces with more realistic and varied data
20.times do
  Space.create!(
    title: "#{Faker::Educator.subject} Study Space",
    description: Faker::Lorem.paragraph(sentence_count: 3),
    facilities: Faker::House.furniture,
    equipment: Faker::Appliance.equipment,
    capacity: rand(1..20),
    availability: [true, false].sample,
    user: users.sample
  )
end
