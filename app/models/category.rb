class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :events, :through => :categorizations

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  has_attached_file :image, :styles => { :small => "100x100#", :medium => "250x250#" }
  
  validates :name, :uniqueness => true
  validates_presence_of :description, :image

  def to_param
    "#{name.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end
end
