# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             role: 2)
User.create!(name:  "Demo User",
             email: "example@mail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             role: 1)

99.times do |n|
  name  = Faker::Name.name
  email = "mail-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               role: 0)
end

10.times do
  name = Faker::Lorem.words(2).join(' ')
  Category.create!(name: name)
end

categories = Category.all
categories.each do |category|
  20.times do
    content = Faker::Lorem.word
    category.words.create!(content: content)
  end
end