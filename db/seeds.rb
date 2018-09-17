10.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@gmail.com"
  password = "password"
  User.create!(fullname: name,
    email: email,
    password: password,
    role: :customer,
    money: 300)
end

user = User.create!(fullname: "Admin",
  email: "admin@gmail.com",
  password: "password",
  role: :admin,
  money: 300)
user.confirm

["Africa", "Asia", "Europe", "North America", "South America",
  "Antarctica", "Australia", "Oceania"].each do |con|
  Continent.create!(name: con)
end
