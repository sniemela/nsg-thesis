class Client < ActiveRecord::Base
  has_many :advertises
  belongs_to :client_type
end
