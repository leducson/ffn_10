class HomeController < ApplicationController
  def index
    @matches = Match.includes(round: :league).ranger_date_match(Date.today + 10.days).newest.group_by(&:round)
  end
end
