class NotificationMailer < ActionMailer::Base
  default from: "do-not-reply@pronoun.io"

  def scheduled_demo(user)
    email = user.email
    mail(:to => email, :subject => "The requested sitemap has been generated")
  end
end