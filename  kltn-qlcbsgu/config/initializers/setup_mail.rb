ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
:enable_starttls_auto => false,
:address => "mail.google.com",
:port => 25,
:domain => "yourdomain.com",
:user_name => "maitrithien@gmail.com",
:password => "M@iTriThien",
:authentication => :login
}