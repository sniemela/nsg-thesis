require 'nodejs_notifier'

class Event < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, :through => :categorizations

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  after_create :notify_created
  after_update :notify_updated

  private
    def notify_updated
      NodejsNotifier.notify('/event_updated', to_json)
    end

    def notify_created
      NodejsNotifier.notify('/event_added', to_json)
    end
end
