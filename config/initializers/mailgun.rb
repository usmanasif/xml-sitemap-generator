ActionMailer::Base.smtp_settings = {
  :port           => 587,
  :address        => Rails.application.secrets.MAILGUN_SMTP_SERVER,
  :user_name      => Rails.application.secrets.MAILGUN_SMTP_LOGIN,
  :password       => Rails.application.secrets.MAILGUN_SMTP_PASSWORD,
  :domain         => 'sandbox91dc0443544e4670a7dd16cf8e564f8e.mailgun.org',
  :authentication => :plain,
}
ActionMailer::Base.delivery_method = :smtp
