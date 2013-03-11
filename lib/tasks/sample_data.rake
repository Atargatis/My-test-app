namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(username: "Example User",
                 email: "example@mail.com",
                 password: "foobarbaz",
                 password_confirmation: "foobarbaz")
    99.times do |n|
      username  = Faker::Name.name
      email = "example-#{n+1}@mail.com"
      password  = "password"
      User.create!(username: username,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end