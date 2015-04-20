class CreateCustomizableAdminPermissionsResources < ActiveRecord::Migration
  def change
    create_table :cadm_permissions_resources do |t|
      t.integer :permission_id
      t.string :resource_type
      t.integer :resource_id

      t.timestamps null: false
    end
    # Set admin permission
    admin = CustomizableAdmin::Settings::User.find(1)
    admin.update_attributes({permission_ids: [1]})
  end
end
