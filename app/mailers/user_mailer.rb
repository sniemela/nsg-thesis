class UserMailer < ActionMailer::Base
  default :from => "email_address_here"
  default_url_options[:host] = "localhost:3000"

  def event_sent_to_admin(event, user)
    @user = user
    @event = event
    mail(:to => "#{user.email}", :subject => "Event has been sent to admin")
  end
  
  def event_published(event, user)
    @user = user
    @event = event
    mail(:to => "#{user.email}", :subject => "Event has been published")
  end
  
  def notice_admin(event, user)
    @user = user
    @event = event
    mail(:to => "admins_email_address", :subject => "Client has published an event")
  end
end
