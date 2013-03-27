ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = false
ActionMailer::Base.smtp_settings = {
:enable_starttls_auto => false,
:address => "your.domain.com",
:port => 25,
:domain => "yourdomain.com",
:user_name => "yourname@domain.com",
:password => "whatever",
:authentication => :login
}