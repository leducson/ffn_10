class HomeController < ApplicationController
  def index
    @matches = Match.includes(round: :league).ranger_date_match(Date.today + Settings.day.days).newest.group_by(&:round)
  end
end
