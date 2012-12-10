class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :name
      t.integer :category_id
      t.text :description
      t.string :author
      t.decimal :rating, :default => 0
      t.integer :rates_count, :default => 0

      t.timestamps
    end
  end
  
  def self.down
    drop_table :photos
  end
end