class Gallery < ActiveRecord::Base
  has_many :gallery_resources, :dependent => :destroy
  belongs_to :event

  accepts_nested_attributes_for :gallery_resources,
      :allow_destroy => true,
      :reject_if => lambda { |a| a['resource'].nil? }
end
