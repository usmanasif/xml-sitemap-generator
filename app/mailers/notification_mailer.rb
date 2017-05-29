class NotificationMailer < ActionMailer::Base
  default from: "do-not-reply@pronoun.io"

  def scheduled_demo(user)
    email = user.email
    if Rails.application.secrets.mailgun_smtp_domain == 'sandboxcf3313b993e84c58a40b85ce284eee90.mailgun.org'
      email = Rails.application.secrets.developer_email
    end
    
    mail(:to => email, :subject => 'The requested sitemap has been generated')
  end

  def error_in_mailer(error)
    email = Rails.application.secrets.developer_email

    mail(:to => email, :subject => 'There is an error in Action Mailer', error: error)
  end
end
