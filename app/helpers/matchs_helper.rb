module MatchsHelper
  def format_score result
    return "?" unless result.present?
    result.score
  end

  def format_match_ready match
    return "FT" if match.finish?
    return if match.pending?
    "<span class='minute_blink'>#{match.time}'</span>" if match.ready?
  end

  def format_league_and_round_name round
    "<b>#{round.league_name}</b> - #{round.name}"
  end

  def format_score_sugest sugest
    "#{sugest.score_win} - #{sugest.score_lost}"
  end
end
