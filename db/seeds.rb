# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

pp "These seeds will be created in #{ActiveRecord::Base.connection.current_database}"

# Destroy
pp "Killing bookings first"
Booking.destroy_all
pp "Now destroying the old User seeds. Burning them with fire..."
User.destroy_all
pp "Done."

# Create new users
pp "Creating users..."

10.times do
  User.create!(
    email: Faker::Internet.safe_email,
    password: Faker::Internet.password(min_length: 10, max_length: 20),
    first_name: Faker::Name.first_name,
    last_name: Faker::Games::ElderScrolls.last_name,
    task: Faker::Commerce.department(max: 2, fixed_amount: true),
    hourly_price: rand(10..50),
    location: "#{Faker::Address.city}, #{Faker::Address.country}",
    description: "#{Faker::Demographic.sex}, #{Faker::Demographic.marital_status}, #{Faker::Demographic.height(unit: :imperial)}. Big #{Faker::Games::Pokemon.name} fan. #{Faker::Games::Pokemon.move}!"
  )
  pp "Seeding users..."
end

# Create new bookings
pp "Creating bookings..."
10.times do
  Booking.create!(
    start_date: Faker::Date.between(from: '2023-08-23', to: '2023-09-25'),
    end_date: Faker::Date.between(from: '2023-09-26', to: '2023-09-30'),
    total_price: rand(10..1000),
    user_bookee: User.order("RANDOM()").first,
    user_booker: User.order("RANDOM()").last,
    hours_per_day: rand(1..24),
    description: "I need someone specialised in #{Faker::Commerce.department(max: 2, fixed_amount: true)}. Ideally with some history of professional #{Faker::Hobby.activity} and #{Faker::Job.field}. Must also be able to #{Faker::Company.bs}. Experience with #{Faker::Appliance.brand} #{Faker::Appliance.equipment}s is required. THIS JOB IS A SECRET. When we meet, don't be #{Faker::Verb.past_participle}, just remember: #{Faker::Marketing.buzzwords}."
  )
  pp "Seeding bookings..."
end

pp "Created #{User.count} users."
pp "Created #{Booking.count} bookings."
pp "New seeds have been created. Long live the new seeds"
