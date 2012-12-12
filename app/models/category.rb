class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :photos, :dependent => :delete_all
  # befor_filter
  # railscast #23
  validates :name, presence: true
end
