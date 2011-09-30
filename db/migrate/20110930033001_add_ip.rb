class AddIp < ActiveRecord::Migration
  def change
    change_table :lols do |t|
      t.string :ip
    end
  end
end
