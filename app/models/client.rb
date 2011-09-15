class Client < ActiveRecord::Base
  has_many :ads
  has_many :events, :as => :submitter

  belongs_to :client_type
  belongs_to :user

  attr_accessible :name, :description, :address, :country
  validates :name, :description, :address, :country, :presence => true

  scope :unconfirmed, where(:confirmed => false)

  before_create :autoconfirm

  def autoconfirm
    self[:confirmed] = true if user.admin?
  end
end
