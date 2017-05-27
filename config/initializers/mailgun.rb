ActionMailer::Base.smtp_settings = {
  :port           => 587,
  :address        => Rails.application.secrets.MAILGUN_SMTP_SERVER,
  :user_name      => Rails.application.secrets.MAILGUN_SMTP_LOGIN,
  :password       => Rails.application.secrets.MAILGUN_SMTP_PASSWORD,
  :domain         => Rails.application.secrets.MAILGUN_SMTP_DOMAIN,
  :authentication => :plain
}

ActionMailer::Base.delivery_method = :smtp
