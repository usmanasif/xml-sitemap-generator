ActionMailer::Base.smtp_settings = {
  :port           => 587,
  :address        => Rails.application.secrets.mailgun_smtp_server,
  :user_name      => Rails.application.secrets.mailgun_smtp_login,
  :password       => Rails.application.secrets.mailgun_smtp_password,
  :domain         => Rails.application.secrets.mailgun_smtp_domain,
  :authentication => :plain
}

ActionMailer::Base.delivery_method = :smtp
