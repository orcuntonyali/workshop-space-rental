# This file should contain all the record creation needed to seed the database with its default values.

# Clear previous seeds
Space.destroy_all
User.destroy_all

# Reset primary key sequence
ActiveRecord::Base.connection.reset_pk_sequence!('spaces')
ActiveRecord::Base.connection.reset_pk_sequence!('users')

# Create master user
User.create!(
  email: "tonyaliorcun@gmail.com",
  password: '123456',
  username: "orcuntonyali",
  first_name: "Orcun",
  last_name: "Tonyali",
  role: "booker"
)

# Create 5 listers
listers = 5.times.map do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: '123456',
    username: Faker::Internet.unique.username,
    role: 'lister'
  )
end

# German city names
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
  'Leipzig',
  'Bremen',
  'Dresden',
  'Hannover',
  'Nuremberg',
  'Duisburg',
  'Bochum',
  'Wuppertal',
  'Bielefeld',
  'Bonn',
  'Münster'
]
# Facilities
facilities = [
  'Wi-Fi',
  'Power outlets',
  'Air conditioning',
  'Heating',
  'Whiteboard',
  'Projector',
  'Printer',
  'Scanner',
  'Coffee machine',
  'Kitchen',
  'Parking'
]
# Equipment
equipment = [
  'Laptop',
  'Monitor',
  'Keyboard',
  'Mouse',
  'Headphones',
  'Microphone',
  'Webcam',
  'Tablet',
  'Smartphone',
  'Camera'
]

# Create 15 spaces
spaces = 15.times.map do
  city = cities.sample
  lister = listers.sample

  # Generate 70% available dates for the next year
  total_days = 100
  available_dates = []
  start_date = DateTime.now

  (start_date..start_date + total_days.days).each do |date|
    if rand < 0.5 # 70% chance of being available
      formatted_date = date.strftime("%Y-%m-%d")
      available_dates << formatted_date
    end
  end

  Space.create!(
    title: "#{Faker::Educator.subject} Space",
    description: Faker::Lorem.paragraph(sentence_count: 3),
    facilities: facilities.sample(rand(1..5)).join(', '),
    equipment: equipment.sample(rand(1..5)).join(', '),
    capacity: rand(1..20),
    available_dates: available_dates,
    user: lister,
    address: "#{Faker::Address.street_address}, #{city}",
    city: city,
    latitude: Geocoder.search(city).first.latitude,
    longitude: Geocoder.search(city).first.longitude,
    price: rand(15..68)
  )
end

# Create 100 reviewers
reviewers = 25.times.map do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: '123456',
    username: Faker::Internet.unique.username,
    role: 'booker'
  )
end
# Create bookings for spaces
bookings = spaces.map do |space|
  reviewer = reviewers.sample
  Booking.create!(
    user: reviewer,
    space: space
  )
end

# Create reviews for bookings
bookings.each do |booking|
  rand(0..3).times do
    reviewer = reviewers.sample

    next if Review.exists?(user: reviewer, space: booking.space)  # Skip if this user has already reviewed this space

    Review.create!(
      rating: rand(3..5),
      comment: Faker::Lorem.paragraph(sentence_count: 3),
      user: reviewer,
      space: booking.space,
      booking: booking
    )
  end
end
