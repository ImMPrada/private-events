# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if User.all.empty?
  10.times do
    user = User.new

    user.username = Faker::Internet.username(specifier: 3...20)
    user.email = Faker::Internet.email
    user.password = 'Password1!'

    puts 'user created' if user.save
  end
end

if Event.all.empty?
  50.times do
    user = User.all.sample
    dates = Date.new([2001, 1995, 2015, 2020, 2022, 2023].sample, 03, 03)

    event_params = {
      title: Faker::Quote.famous_last_words,
      description: Faker::Quote.yoda,
      start_date: dates,
      end_date: dates
    }

    event = user.created_events.build(event_params)
    puts 'event created' if event.save
  end
end
