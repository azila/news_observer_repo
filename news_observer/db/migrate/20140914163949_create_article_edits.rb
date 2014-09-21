class CreateArticleEdits < ActiveRecord::Migration
  def up
    create_table :article_edits do |t|
      t.references :admin_user
      t.references :article
      t.string :summary
      t.timestamps
    end
    add_index :article_edits, ["admin_user_id", "article_id"]
  end

  def down
    drop_table :article_edits
  end
  
end
