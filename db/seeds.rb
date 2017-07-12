# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create(email: "admin@alphadeal.co", password: "groupsitE619", password_confirmation: "groupsitE619")

Currency.create(country: "India", extension: "Rs.")
Currency.create(country: "USA", extension: "$")

Type.create(name: "Phone call")
Type.create(name: "Dinner")
Type.create(name: "Meeting")
Type.create(name: "Task")
Type.create(name: "Target")
Type.create(name: "Email")

Visibility.create(name: "Everyone in my team")
Visibility.create(name: "Creator Only")

Plan.create(name: "Grande", number_users: 10, duration: 12, price: 0)