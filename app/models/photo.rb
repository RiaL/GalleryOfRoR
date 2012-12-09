class Photo < ActiveRecord::Base
  attr_accessible :author, :description, :mark, :name, :photo, :tags, :picture, :category_id
  belongs_to :category
  has_attached_file :picture, :styles => { :small => "150x150>" , :normal => "600x600>"}
end
