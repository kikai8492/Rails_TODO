# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               )
end

# 10.times do |n|
#   User.create!(name: "kikai#{n+1}",
#     email: "yysskikai#{n + 1}@icloud.com",
#     password:  "aaaaaa",
#     admin: false)
# end
# Task.create!([
#   { not_started_yet: 'タスク1', content: 'タスク1の内容', expired_at: '2021-08-28', status: '未着手', priority: '低', user_id: 1 }
# ])

User.all.each do |user|
  user.tasks.create!([
    not_started_yet: 'タスク1', 
    content: 'タスク1の内容', 
    expired_at: '2021-08-28', 
    status: '未着手', 
    priority: '低'
  ])
end

10.times do |n|
  Tag.create!([
    { title: "タグ#{n + 1}" }
  ])
end