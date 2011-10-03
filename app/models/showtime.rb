class Showtime < ActiveRecord::Base
  validates :start_time, :presence => true

  belongs_to :event
end
