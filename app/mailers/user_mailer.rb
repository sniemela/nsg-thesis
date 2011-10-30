class UserMailer < ActionMailer::Base
  default from: "info@happen.com"

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
end
