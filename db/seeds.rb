50.times do |n|
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
    activated_at: Time.zone.now)
end

User.create!(fullname: "Admin",
  email: "admin@gmail.com",
  gender: "Male",
  password: "password",
  password_confirmation: "password",
  activated: true,
  admin: true,
  activated_at: Time.zone.now)

50.times do |n|
  FootballNew.create!(title: Faker::Lorem.word, content: Faker::Lorem.paragraph)
end

20.times do |n|
  Comment.create!(message: Faker::Lorem.paragraph,
    user_id: User.all.sample.id,
    football_new_id: FootballNew.all.sample.id)
end

10.times do |n|
  League.create!(name: Faker::Team.name,
    country:Faker::Address.country,
    start_date: Date.today + (n + 10).days,
    end_date: Date.today + 40.days,
    continents: "", number_of_match: rand(10..40),
    number_of_team: rand(5..20),
    match_time: 90,
    number_of_round: rand(3..10))
end

30.times do |n|
  Team.create!(name: Faker::WorldCup.team,
    country: Faker::Address.country,
    address: Faker::Address.full_address,
    establish_year: Faker::Date.between(2.days.ago, 10.year.ago),
    continents: "",
    league_id: League.all.sample.id)
end



leagues = League.order(:created_at)
30.times do |n|
  leagues.each {|league| league.rounds.create!(name: Faker::Team.name)}
end

leagues.each do |league|
  league.number_of_team.to_i.times do |n|
    league.rankings.create!(team_id: league.teams.sample.id,
      rank: (0..league.number_of_team.to_i))
  end
end

30.times do |n|
  Match.create!(date_of_match: Date.today + (rand(10..20)).days,
    extra_time1: nil,
    extra_time2: nil,
    time: nil,
    team1_id: n + 1,
    team2_id: rand(2..30),
    round_id: Round.all.sample.id)
end

teams = Team.order(:created_at)
teams.each do |team|
  team.player_infos.create!(name: Faker::Name.name,
    date_of_birth: Faker::Date.birthday(18, 35),
    gender: "Female",
    weight: rand(50..90),
    height: rand(160..195),
    position: "",
    number: rand(0..100))
end

matchs = Match.order(:created_at).take(10)
30.times do |n|
  type = MatchInfo.types.to_a.sample
  message = type.first.titleize

  matchs.each do |m|
    m.match_infos.create!(message: message,
      type_info: type[1],
      minutes: n + 10)

    m.create_match_result(score_win: rand(2..5),
      score_lost: rand(0..1),
      win_team_id: m.team1_id,
      lost_team_id: m.team2_id)

    6.times.each do |n|
      score = 1
      ratio = 6
      m.score_sugests.create!(ratio: ratio + n, score_win: score + 1, score_lost: 0)
    end

    6.times.each do |n|
      score = 1
      ratio = 8
      m.score_sugests.create!(ratio: ratio + n, score_win: 0, score_lost: score + 1)
    end
  end
end

matchs.each do |match|
  match.score_bets.create!(price: rand(10..1000),
    status: ScoreBet.statuses.to_a.sample[1],
    match_id: Match.all.sample.id,
    user_id: User.all.sample.id,
    score_sugest_id: ScoreSugest.all.sample.id)
end

score_bets = ScoreBet.order(:created_at)
score_bets.each do |score_bet|
  score = "#{score_bet.score_sugest.score_win} - #{score_bet.score_sugest.score_lost}"

  match = "#{score_bet.match.team1.name} - #{score_bet.match.team2.name}"

  user = User.where("admin = ?", false).sample

  score_bet.notifies.create!(user_id: user.id,
    message: "You are bet score #{score} in match #{match}")
  score_bet.notifies.create!(user_id: User.where("admin = ?", true).last.id,
    message: "#{user.fullname} is bet score #{score} in match #{match}")
end

users = User.order(:created_at).take(6)
30.times do |n|
  users.each do |user|
    amount = rand(10..300)
    user.credits.create!(amount: amount, credit_type: Credit.types.to_a.sample[1])
    user.notifies.create!(message: "You are added #{amount}$ to you account!", score_bet_id: nil)
  end
end
