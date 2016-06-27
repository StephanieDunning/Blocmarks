class UserMailer < ApplicationMailer
  default from: 'eggandcheesesandwich@gmail.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to Blocmarks!')
  end

  def receive(email)
    @user = email.sender
    @topic = email.subject
    @url = params["body-plain"]
  end
end
