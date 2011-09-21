class Gallery < ActiveRecord::Base
  has_many :gallery_resources, :dependent => :destroy
  belongs_to :event
end
