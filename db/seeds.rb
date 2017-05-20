# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


10.times do
  User.create(
    first_name: Faker::Lorem.words(1),
    last_name: Faker::Lorem.words(1),
    email: Faker::Internet.email ,
    bio: Faker::Lorem.paragraph,
    phone: Faker::PhoneNumber.phone_number
  )
end

10.times do
  Job.create(
    title: Faker::Book.title,
    description: Faker::TwinPeaks.quote,
    when: Faker::Date.forward(3),
    show: Faker::Book.genre,
    tcp: true,
    car: true,
    aasm_state: 'Open',
    address: "601 W Cordova St",
    user_id: Random.rand(1...9)
  )
end
