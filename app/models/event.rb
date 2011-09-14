require 'nodejs_notifier'

class Event < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, :through => :categorizations

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  belongs_to :submitter, :polymorphic => true

  after_create :notify_created
  after_update :notify_updated

  scope :most_watched, where('times_watched > ?', 0).order('times_watched desc').limit(50)
  scope :popular, where('liked_count > ?', 0).order('liked_count desc').limit(50)
  scope :recent, where('created_at >= ?', Time.now - 1.week)
  scope :between, lambda { |from, to| where('created_at between ? and ?', from, to) }
  scope :approved, where(:approved => true)
  scope :unapproved, where(:approved => false)

  def approve!
    self[:approved] = true
    save!
  end

  private
    def notify_updated
      NodejsNotifier.notify('/event_updated', to_json)
    end

    def notify_created
      NodejsNotifier.notify('/event_added', to_json)
    end
end
