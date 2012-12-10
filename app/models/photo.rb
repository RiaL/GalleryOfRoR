class Photo < ActiveRecord::Base
  attr_accessible :author, :description, :name, :picture, :category_id, :tag_list
  belongs_to :category
  has_attached_file :picture, :styles => { :small => "150x150>" , :medium => "300x300>"}
  validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png']
  validates_presence_of :name, :message => "Nazwa musi byc"
  acts_as_taggable
end
