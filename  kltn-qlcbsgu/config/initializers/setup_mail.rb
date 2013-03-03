ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = false
ActionMailer::Base.smtp_settings = {
:enable_starttls_auto => false,
:address => "mail.yourdomain.com",
:port => 25,
:domain => "yourdomain.com",
:user_name => "donotreply@yourdomain.com",
:password => "whatever",
:authentication => :login
}