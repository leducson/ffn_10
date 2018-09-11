module MatchInfosHelper
  def format_message info
    "#{info.team_name} -
      #{info.player_info_name}(#{info.player_info_number}) - #{info.message}"
  end
end
