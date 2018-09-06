class HomeController < ApplicationController
  def index
    @leagues = League.includes :rounds, :teams, :rankings
  end
end
