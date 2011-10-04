class Showtime < ActiveRecord::Base
  default_scope order('start_time ASC')

  validates :start_time, :presence => true

  belongs_to :event
end
