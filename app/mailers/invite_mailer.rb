class InviteMailer < ApplicationMailer
  def send_invite(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
