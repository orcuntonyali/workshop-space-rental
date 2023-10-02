# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear previous seeds
Space.destroy_all
User.destroy_all

# Reset primary key sequence
ActiveRecord::Base.connection.reset_pk_sequence!('spaces')
ActiveRecord::Base.connection.reset_pk_sequence!('users')

# Create a few users
users = 5.times.map do
  User.create!(
    email: Faker::Internet.unique.email,
    password: '123456',
    username: Faker::Internet.unique.username,
    role: ['booker', 'lister'].sample
  )
end

# Define an array of real German city names
cities = [
  'Berlin',
  'Hamburg',
  'Munich',
  'Cologne',
  'Frankfurt',
  'Stuttgart',
  'Düsseldorf',
  'Dortmund',
  'Essen',
  'Leipzig'
]

# Create users with data
10.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: '123456',
    username: Faker::Internet.unique.username,
    role: ['booker', 'lister'].sample
  )
end

# Create spaces with data
20.times do
  city = cities.sample
  address = "#{Faker::Address.street_address}, #{city}"
  result = Geocoder.search(city).first

  if result.present?
    Space.create!(
      title: "#{Faker::Educator.subject} Study Space",
      description: Faker::Lorem.paragraph(sentence_count: 3),
      facilities: Faker::House.furniture,
      equipment: Faker::Appliance.equipment,
      capacity: rand(1..20),
      availability: [true, false].sample,
      user: User.all.sample,
      address: address,
      latitude: result.latitude,
      longitude: result.longitude
    )
  else
    puts "Unable to geocode city: #{city}"
  end
end
