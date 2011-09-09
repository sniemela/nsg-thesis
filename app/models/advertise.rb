class Advertise < ActiveRecord::Base
  belongs_to :client

  has_attached_file :media
end
