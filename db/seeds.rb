# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts 'Seeding Users...'
User.create(email: 'user1@gmail.com', name: 'user1', password: '11111111', role: "admin")
User.create(email: 'user2@gmail.com', name: 'user2', password: '11111111')
User.create(email: 'user3@gmail.com', name: 'user3', password: '11111111')
User.create(email: 'user4@gmail.com', name: 'user4', password: '11111111', role: "admin")
puts 'Seeding Users done.'

puts 'Seeding Courses...'
Course.create(creator: 'user4',language: 'js',name: 'course1')
Course.create(creator: 'user3',language: 'ruby',name: 'course2')
Course.create(creator: 'user3',language: 'php',name: 'course3')
Course.create(creator: 'user3',language: 'java',name: 'course4')
Course.create(creator: 'user4',language: 'python',name: 'course5')
Course.create(creator: 'user3',language: 'R',name: 'course6')
Course.create(creator: 'user4',language: 'haskell',name: 'course7')
puts 'Seeding Courses done.'

