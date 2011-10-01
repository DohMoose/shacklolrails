class CreateInitialTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :shackname, index: { unique: true ,case_sensitive: false}

      t.timestamps
    end

    create_table :links do |t|
      t.integer :post_id, references: nil, index: true
      t.integer :article_id, references: nil, index: true
      t.integer :original_post_id, references: nil, index: true
      t.integer :user_id
      t.string :moderation
      t.datetime :date, index: true
      t.text :cache

      t.timestamps
    end

    create_table :lols do |t|
      t.integer :user_id
      t.integer :link_id
      t.integer :lol_type_id
      t.string :version
      t.string :ip

      t.timestamps
    end
  end
end
