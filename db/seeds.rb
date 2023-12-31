# This file should contain all the record creation needed to seed the database with its default values.

# Clear previous seeds
puts "Cleaning Records..."
Space.delete_all
User.delete_all

# Reset primary key sequence
puts "Resetting primary key sequence..."
ActiveRecord::Base.connection.reset_pk_sequence!('spaces')
ActiveRecord::Base.connection.reset_pk_sequence!('users')

# Create master user
puts "Creating master user..."
User.create!(
  email: "tonyaliorcun@gmail.com",
  password: '123456',
  username: "orcuntonyali",
  first_name: "Orcun",
  last_name: "Tonyali",
  role: "booker"
)

# Create 5 listers
puts "Creating listers..."
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
  'Düsseldorf'
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
puts "Creating spaces..."
photos = ["https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419179/Workshop/1.avif",
  "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419179/Workshop/2.avif",
  "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696597444/23_jzhrkd.avif",
  "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419178/Workshop/4.avif",
  "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419178/Workshop/5.avif",
  "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419174/Workshop/17.avif",
  "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419173/Workshop/19.avif",
  "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419176/Workshop/10.avif",
  "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419175/Workshop/12.avif",
  "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419175/Workshop/14.avif",
  "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419175/Workshop/15.avif",
  "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696597443/21_lwm8h9.avif",
  "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696597442/20_mnubg8.avif",
  "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696597443/22_bghtuh.avif"]
spaces = photos.each_with_index do |photo, index|
  city = cities.sample
  lister = listers.sample

#   # Generate 50% available dates for the next year
  puts "Generating available dates..."
  available_dates = []
  date = DateTime.now

  100.times do
    # 50% chance of being available
    available_dates << date.strftime("%Y-%m-%d") if rand < 0.3
    date += 1
  end

  puts "Creating space..."
  file = URI.open(photo)

  space = Space.new(
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
  space.photo.attach(io: file, filename: "#{index}.png", content_type: "image/png")
  space.save
end




puts "Creating bookings..."
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
puts "Creating bookings..."
# Create bookings for spaces
bookings = Space.all.map do |space|
  reviewer = reviewers.sample
  Booking.create!(
    user: reviewer,
    space:
  )
end
puts "Creating reviews..."
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
