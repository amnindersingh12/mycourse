# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# Character.create(name: "Luke", movie: movies.first)
puts 'Seeding Users...'
User.create(email: 'user1@gmail.com', name: 'user1', password: '11111111', role: 1)
User.create(email: 'user2@gmail.com', name: 'user2', password: '11111111', role: 2)
User.create(email: 'user3@gmail.com', name: 'user3', password: '11111111', role: 0)
User.create(email: 'user4@gmail.com', name: 'user4', password: '11111111', role: 1)
puts 'Seeding Users done.'

puts 'Seeding Courses...'
Course.create(language: 'js', name: 'course1', user_id: 4, superuser_id: 4)
Course.create(language: 'ruby', name: 'course2', user_id: 1, superuser_id: 1)
Course.create(language: 'php', name: 'course3', user_id: 1, superuser_id: 1)
Course.create(language: 'java', name: 'course4', user_id: 1, superuser_id: 1)
Course.create(language: 'python', name: 'course5', user_id: 4, superuser_id: 4)
Course.create(language: 'R', name: 'course6', user_id: 1, superuser_id: 1)
Course.create(language: 'haskell', name: 'course7', user_id: 4, superuser_id: 4)
puts 'Seeding Courses done.'

puts 'Seeding UserCourse...'
UserCourse.create(user_id: 4, course_id: 2)
UserCourse.create(user_id: 2, course_id: 3)
UserCourse.create(user_id: 3, course_id: 4)
UserCourse.create(user_id: 1, course_id: 1)
UserCourse.create(user_id: 3, course_id: 5)
UserCourse.create(user_id: 2, course_id: 7)
UserCourse.create(user_id: 4, course_id: 6)

puts 'Seeding UserCourse done.'
