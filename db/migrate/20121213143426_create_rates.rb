class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :user_id
      t.integer :photo_id
      t.integer :value

      t.timestamps
    end
  end
end
