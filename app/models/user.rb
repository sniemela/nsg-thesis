# encoding: utf-8

class User < ActiveRecord::Base
  belongs_to :client
  has_many :events, :as => :submitter
  has_many :comments

  def all_events
    Event.where(["(events.submitter_id = ? and events.submitter_type = 'Client') or (events.submitter_id = ? and events.submitter_type = 'User')", client_id, id]).select('distinct events.*')
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = auth["user_info"]["email"]
      user.avatar = auth["user_info"]["image"]
    end
  end

  def has_event?(event)
    return true if events.exists?(event)
    return true if client && client.events.exists?(event)
    return false
  end
  
  def has_comment?(comment)
    return true if comments.exists?(comment)
    return false
  end
end
