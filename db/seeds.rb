# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#street = ["100 Main St.", "200 High St.", "300 Pine St."]
#city = ["Melbourne, Australia", "Boston, Massachusetts", "Oakland, California"]
addresses = ["1111 Gough St, San Francisco, CA 94109, USA", "1150 Market St, San Francisco, CA 94102, USA", "425 Market St, San Francisco, CA 94105, USA", "5 Embarcadero Center, San Francisco, CA 94111, USA","1807 Telegraph Ave, Oakland, CA 94612, USA", "1001 Broadway, Oakland, CA 94607, USA", "1900 Broadway, Oakland, CA 94612, USA", "144 High St, Prahran VIC 3181", "King St & Flinders St, Melbourne VIC 3000", "21 S Wharf Promenade, South Wharf VIC 3006", "513 Elizabeth St, Melbourne VIC 3000", "124 La Trobe St, Melbourne VIC 3000"]

100.times do |n|
  name  = Faker::Name.name
  email = Faker::Internet.unique.safe_email
  password = "password"
  User.create!(name:                  name,
               email:                 email,
               password:              password,
               password_confirmation: password)
end

50.times do |n|
  title = Faker::Hipster.sentence(1, false)
  description = Faker::Hipster.paragraph(2, false, 4)
  #location = Faker::Address.street_address + " " + Faker::Address.city
  time = Faker::Time.between(1.month.ago, 1.month.from_now)
  #creator = c
  creator = User.offset(rand(User.count)).first
  Event.create!(title:        title.titleize,
                description:  description,
                location:     addresses.sample,
                date:         time,
                creator:      creator)
end

User.count.times do |n|
  attendee_id = User.find(Faker::Number.unique.between(1, User.count))

  Event.count.times do |n|
    attended_event_id = Event.find(n + 1)

    Invitation.create!(attendee:         attendee_id,
                       attended_event:   attended_event_id)
  end
end
