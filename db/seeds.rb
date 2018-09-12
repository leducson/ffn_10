10.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@gmail.com"
  password = "password"
  User.create!(fullname: name,
    email: email,
    gender: ["Male", "Female"].sample,
    password: password,
    password_confirmation: password,
    activated: true,
    admin: false,
    activated_at: Time.zone.now,
    money: 300)
end

User.create!(fullname: "Admin",
  email: "admin@gmail.com",
  gender: "Male",
  password: "password",
  password_confirmation: "password",
  activated: true,
  admin: true,
  activated_at: Time.zone.now,
  money: 300)

["Africa", "Asia", "Europe", "North America", "South America",
  "Antarctica", "Australia", "Oceania"].each do |con|
  Continent.create!(name: con)
end
