# encoding: utf-8

class User < ActiveRecord::Base
  belongs_to :client
  has_many :events, :as => :submitter

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = auth["user_info"]["email"]
    end
  end
end
