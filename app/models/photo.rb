class Photo < ActiveRecord::Base
  attr_accessible :author, :description, :mark, :name, :tags, :picture, :category_id
  belongs_to :category
  has_attached_file :picture, :styles => { :small => "150x150>" , :medium => "300x300>"}
  validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png']
  validates_presence_of :name
end
