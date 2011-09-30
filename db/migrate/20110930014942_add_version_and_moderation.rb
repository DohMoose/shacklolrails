class AddVersionAndModeration < ActiveRecord::Migration
  def change 
    change_table :links do |t|
      t.string :moderation
    end
    change_table :lols do |t|
      t.string :version
    end
  end
end
