class CreateCategories < ActiveRecord::Migration
  def up
    create_table :categories do |t|
      t.integer "newspaper_id"
      # same as: t.references :newspaper
      t.string "name"
      t.string "permalink"
      t.integer "position"
      t.boolean "visible", :default => false
      t.timestamps
    end
  	add_index("categories", "newspaper_id")
    add_index("categories", "permalink")
  end

  def down
    drop_table :categories
  end

end
