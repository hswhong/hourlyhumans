# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Destroy
pp "Destroy the old User seeds."
pp "Burning them with fire..."
User.destory_all
pp "And the Buddy seeds."
Buddy.destory_all
pp "And the bookings? Yes. Even the bookings."
Booking.destory_all

# Create new users
pp "Creating new, perfect users..."

10.times do
  User.create(
    first_name: Faker::Games::ElderScrolls.first_name,
    last_name: Faker::Games::ElderScrolls.last_name,
    email_address: Faker::Internet.safe_email,
    password: Faker::Internet.password(min_length: 10, max_length: 20),
    location: "#{Faker::Address.city}, #{Faker::Address.country}",
    task: Faker::Commerce.department(max: 2, fixed_amount: true)
  )
  pp "Seeding..."
end

# Create new bookings
pp "Creating dangerous and illegal bookings..."
10.times do
  Booking.create(
    start_date: Faker::Date.between(from: '2023-08-23', to: '2023-09-25'),
    end_date: Faker::Date.between(from: '2023-09-26', to: '2023-09-30'),
    total_price: rand(10..1000),
    user_bookee_id: rand(0..10),
    user_booker_id: rand(0..10),
    description: "#{Faker::Hobby.activity} and #{Faker::Job.field}. Ideally will not be allergic to #{Faker::Food.allergen}. Must also be able to #{Faker::Company.bs} and have good #{Faker::Job.key_skill}. Experience with #{Faker::Appliance.brand} #{Faker::Appliance.equipment}s is required. When we meet, remember: #{Faker::Marketing.buzzwords}." ,
  )
end



pp "New seeds have been created. Long live the new seeds"
