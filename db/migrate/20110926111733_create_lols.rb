class CreateLols < ActiveRecord::Migration
  def change
    create_table :lols do |t|
      t.integer :user_id
      t.integer :link_id
      t.integer :lol_type_id

      t.timestamps
    end
  end
end
