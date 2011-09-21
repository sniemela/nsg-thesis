class Client < ActiveRecord::Base
  TYPE_COMPANY = 1
  TYPE_ORGANIZATION = 2
  TYPE_INSTITUTE = 3

  has_many :ads
  has_many :events, :as => :submitter
  has_one :user

  attr_accessible :name, :description, :address, :country
  validates :name, :description, :address, :country, :presence => true

  scope :unconfirmed, where(:confirmed => false)

  before_create :autoconfirm

  def autoconfirm
    self[:confirmed] = true if user.admin?
  end

  def confirm!
    self[:confirmed] = true
    save!
  end
end
