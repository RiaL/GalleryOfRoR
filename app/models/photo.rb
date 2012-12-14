class Photo < ActiveRecord::Base
  attr_accessible :author, :description, :name, :picture, :category_id, :tag_list, :rating, :rates_count
  belongs_to :category
  has_many :rates, :dependent => :delete_all
  has_attached_file :picture, :styles => { :small => "150x150>" , :medium => "250x250>"}
  validates_attachment_presence :picture
  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/png']
  validates :name, presence: true
  acts_as_taggable
  scope :created_last_5, order('created_at desc').limit('5')
end
