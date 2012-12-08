class Photo < ActiveRecord::Base
  attr_accessible :author, :description, :mark, :name, :photo, :tags
  belongs_to :category
end
