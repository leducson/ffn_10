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
end
