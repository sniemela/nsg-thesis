class Showtime < ActiveRecord::Base
  default_scope order('start_time ASC')

  validates :start_time, :presence => true

  belongs_to :event

  validate :check_start_time_is_not_past, :check_end_time_is_not_past

  def check_start_time_is_not_past
    if !self[:start_time].blank? && self[:start_time] < Time.zone.now
      errors.add(:start_time, I18n.t('custom_errors.cant_be_past'))
    end
  end

  def check_end_time_is_not_past
    if !self[:end_time].blank? && !self[:start_time].blank?
      errors.add(:end_time, I18n.t('custom_errors.cant_be_past')) if self[:end_time] < self[:start_time]
    end
  end
end
