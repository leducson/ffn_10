module MaillerHelper
  def format_display_on_mailler bet
    "#{bet.match.team1_name} |
      #{bet.match.get_score_team1.score} -
      #{bet.match.get_score_team2.score} |
      #{bet.match.team2_name}"
  end

  def format_score_mailler bet
    "#{bet.score_sugest_score_win} - #{bet.score_sugest_score_lost}"
  end
end
