class CreateLolTypes < ActiveRecord::Migration
  def change
    create_table :lol_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
