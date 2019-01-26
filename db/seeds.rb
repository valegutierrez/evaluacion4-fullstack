# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Todo.destroy_all
Task.destroy_all
9.times do |i|
  @task = Task.new(
    title: "Cocinar #{Faker::Food.dish}",
    content: Faker::Food.description,
    photo: "http://lorempixel.com/400/200/food/#{i + 1}"
  )
  @task.save!
  @users = User.all
  @users.each do |user|
    user.tasks << @task
  end
end