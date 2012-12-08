class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :name
      t.string :photo
      t.references :category
      t.text :description
      t.string :author
      t.date :date
      t.string :tags
      t.decimal :mark

      t.timestamps
    end
  end
  
  def self.down
    drop_table :photos
  end
end