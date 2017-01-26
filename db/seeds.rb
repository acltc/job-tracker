# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do
  User.create(
    email: Faker::Internet.free_email,
    password: 'password',
    password_confirmation: 'password'
  )
end

200.times do
  @date = Faker::Date.between(3.months.ago, Date.today)
  @lead = Lead.create(
    user_id: rand(1..50),
    name: Faker::Name.name,
    job_title: Faker::Company.profession,
    company: Faker::Company.name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number,
    notes: Faker::Lorem.sentence(2),
    last_action: @date
  )
  Status.create(
    lead_id: @lead.id,
    name: "Sent Invite on LinkedIn",
    date: @date
  )
end
