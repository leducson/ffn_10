module TeamsHelper
  def default_image_team team
    return team.image.large.url if team.image.present?
    "large_team5.jpg"
  end

  def default_image_league league
    return league.image.large.url if league.image.present?
    "large_league2.jpg"
  end

  def default_image_football_new football
    return football.image.medium.url if football.image.present?
    "hazard.jpg"
  end
end
