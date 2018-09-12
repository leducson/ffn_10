class UserMailer < ApplicationMailer
  add_template_helper(MaillerHelper)
  
  def account_activation user
    @user = user
    mail to: user.email, subject: t(".mailer")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t(".pass_reset")
  end

  def match_info money_win, suguest, bet, user
    @user = user
    @money_win = money_win
    @suguest = suguest
    @bet = bet
    @teams = "#{bet.match.team1_name} - #{bet.match.team2_name}"
    mail to: user.email, subject: t(".match_ended")
  end
end
