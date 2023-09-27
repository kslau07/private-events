# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

num_users = 10
num_events = 5
num_attendances = (num_events * 1.5).floor

User.create!(email: 'user@example.com', password: 'password123')

def random_date
  rand(-1000..1000).days.from_now
end

def random_event_text_content
  [[Faker::Restaurant.name + [' Grand Opening', ' Charity Cookoff'].sample, Faker::Restaurant.description],
   [Faker::Esport.event + [' Finals', ' ESporting Event'].sample,
    Faker::Esport.player + 'who plays for ' + Faker::Esport.team + ' will be signing autographs.'],
   [Faker::Kpop.iii_groups + [' Live in Concert', ' Autograph Signing'].sample,
    'KPOP sensation will be here for one night only as they continue to tour the U.S.'],
   [Faker::Company.name + ' Company Function',
    Faker::Company.industry + ' industry leader will host their charity event at...']].sample
end

num_users.times do
  User.create!(email: Faker::Internet.email, password: 'password123')
end

num_events.times do
  random_title, random_description = random_event_text_content
  Event.create!(event_date: random_date, creator_id: (rand(num_users) + 1), title: random_title,
                description: random_description)
end

num_attendances.times do
  Attendance.create!(attendee_id: rand(num_users) + 1, attended_event_id: rand(num_events) + 1)
end

puts 'Database was seeded. It has:'
puts "#{User.count} User #{'record'.pluralize(User.count)},"
puts "#{Event.count} Event #{'record'.pluralize(Event.count)},"
puts "#{Attendance.count} Attendance #{'record'.pluralize(Attendance.count)},"
