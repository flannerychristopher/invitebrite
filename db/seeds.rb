# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do |n|
  name  = Faker::Name.name
  email = Faker::Internet.safe_email
  password = "password"
  User.create!(name:                  name,
               email:                 email,
               password:              password,
               password_confirmation: password)
end

50.times do |n|
  title = Faker::Hipster.sentence(1, false)
  description = Faker::Hipster.paragraph(2, false, 4)
  location = Faker::Address.street_address + " " + Faker::Address.city
  time = Faker::Time.between(1.month.ago, 1.month.from_now)
  #creator = c
  creator = User.offset(rand(User.count)).first
  Event.create!(title:        title.titleize,
                description:  description,
                location:     location,
                date:         time,
                creator:      creator)
end

50.times do |n|
  #attendee_id = User.offset(rand(User.count)).first
  #attended_event_id = Event.offset(rand(Event.count)).first
  attendee_id = User.find(rand(49) + 1)
  attended_event_id = Event.find(n+1)
  Invitation.create!(attendee:         attendee_id,
                     attended_event:   attended_event_id)
end
