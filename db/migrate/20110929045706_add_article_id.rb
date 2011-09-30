class AddArticleId < ActiveRecord::Migration
  def change
    change_table :links do |t|
      t.integer :article_id
    end
  end
end
