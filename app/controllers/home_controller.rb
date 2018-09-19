class HomeController < ApplicationController
  def index
    @matches =
      Match.includes(round: :league).ranger_date.newest.group_by(&:round)
  end
end
