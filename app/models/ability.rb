class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.staff?
      can [:read, :create, :update], :all
      can :load_rounds, Match
      can :set_player_by_team, PlayerInfo
      can [:set_league, :load_players_by_team], Team
      cannot :destroy, :all
    else
      can [:read, :update], User, id: user.id
      can :create, :score_bet
    end
  end
end
