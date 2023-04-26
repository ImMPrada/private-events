# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.new

user.username = 'simelomon_tolomeo'
user.email = 'tolomeo@email.com'
user.password = 'password1!'

puts 'user created' if user.save

user = User.find_by(email: 'tolomeo@email.com')

event_params = {
  title: 'React conf',
  description: 'lets talk about react',
  start_date: '2021-10-10',
  end_date: '2021-10-10'
}

event = user.created_events.build(event_params)
puts 'event created' if event.save

event_params = {
  title: 'Ruby PP',
  description: 'ruby programming y sessions of pair programming',
  start_date: '2021-10-10',
  end_date: '2021-10-10'
}

event = user.created_events.build(event_params)
puts 'event created' if event.save

event_params = {
  title: 'warroom meeting',
  description: 'for programmers xD',
  start_date: '2021-10-10',
  end_date: '2021-10-10'
}

event = user.created_events.build(event_params)
puts 'event created' if event.save
