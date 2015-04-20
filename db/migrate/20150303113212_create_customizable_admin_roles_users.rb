class CreateCustomizableAdminRolesUsers < ActiveRecord::Migration
  def change
    create_table :cadm_roles_users do |t|
      t.integer :role_id
      t.integer :user_id

      t.timestamps null: false
    end
    # Create admin user
    admin = CustomizableAdmin::Settings::User.find(1)
    admin.update_attributes({role_ids: [1]})
  end
end
