class Rate < ActiveRecord::Base
  attr_accessible :photo_id, :user_id, :value
  belongs_to :photo, :counter_cache => true
  belongs_to :user
end
