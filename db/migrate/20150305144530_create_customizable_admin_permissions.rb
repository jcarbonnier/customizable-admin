class CreateCustomizableAdminPermissions < ActiveRecord::Migration
  def change
    create_table :cadm_permissions do |t|
      t.string :name
      t.string :subject_class
      t.integer :subject_id
      t.string :action
      t.text :description

      t.timestamps null: false
    end
    # Create admin user
    CustomizableAdmin::Settings::Permission.create({
                                             name: 'Everything',
                                             subject_class: 'all',
                                             action: 'manage',
                                             description: 'All operations'
                                         })
  end
end
