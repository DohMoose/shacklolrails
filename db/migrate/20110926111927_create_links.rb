class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :post_id
      t.integer :original_post_id
      t.integer :user_id
      t.datetime :date
      t.text :cache

      t.timestamps
    end
  end
end
