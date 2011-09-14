class Client < ActiveRecord::Base
  has_many :advertises
  has_many :events, :as => :submitter

  belongs_to :client_type
  belongs_to :user

  attr_accessible :name, :description, :address, :country
  validates :name, :description, :address, :country, :presence => true
end
