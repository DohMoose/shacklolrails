class CreateAnalyses < ActiveRecord::Migration
  def change
    create_table :analyses do |t|
      t.integer :link_id
      t.integer :last_lol_id
      t.integer :lol_type_id
      t.integer :total
      t.text :lold_by

      t.timestamps
    end
  end
end
