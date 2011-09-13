class Client < ActiveRecord::Base
  has_many :advertises
  has_many :events, :as => :submitter

  belongs_to :client_type
  belongs_to :user
end
