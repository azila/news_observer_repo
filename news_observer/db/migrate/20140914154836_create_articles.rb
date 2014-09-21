class CreateArticles < ActiveRecord::Migration
  
  def change
    create_table :articles do |t|
      t.integer "category_id"
      # same as: t.references :category
      t.string "name"
      t.integer "position"
      t.boolean "visible", :default => false
      t.string "content_type"
      t.text "content"
      t.timestamps
    end
    add_index("articles", "category_id")
  end

end
