namespace :db do
  desc "Fill database with task_manager data"
  task populate: :environment do
    User.create!(name: "User",
                 email: "user@mail.com",
                 password: "xxxxxxxx",
                 password_confirmation: "xxxxxxxx")
    99.times do |n|
      name = Faker::Name.name
      email = "user-#{n+1}@mail.com"
      password = "xxxxxxxx"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 10)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.tasks.create!(content: content) }
    end
  end
end