class CreateAdminUsersCategoriesJoin < ActiveRecord::Migration

   def up
    create_table :admin_users_categories, :id => false do |t|
      t.integer "admin_user_id"
      t.integer "category_id"
    end
    add_index :admin_users_categories, ["admin_user_id", "category_id"]
  end

  def down
    drop_table :admin_users_categories
  end

end
