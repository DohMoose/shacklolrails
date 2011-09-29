class AddArticleId < ActiveRecord::Migration
  def up
    add_column :links, :article_id, :integer
  end

  def down
    remove_column :links, :article_id
  end
end
