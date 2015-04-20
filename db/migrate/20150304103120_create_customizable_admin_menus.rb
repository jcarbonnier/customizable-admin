class CreateCustomizableAdminMenus < ActiveRecord::Migration
  def change
    create_table :cadm_menus do |t|
      t.string :ancestry
      t.string :name
      t.string :class_name
      t.string :glyphicon_name
      t.integer :position, default: 0

      t.timestamps null: false
    end
    # Index
    add_index :cadm_menus, :ancestry
    # Default menus
    CustomizableAdmin::Settings::Menu.create({
                                                       name: 'Dashboard',
                                                       class_name: 'main_app.root_path',
                                                       glyphicon_name: 'dashboard'
                                                   })
    CustomizableAdmin::Settings::Menu.create({
                                                       name: 'Administration',
                                                       class_name: 'administration_root_path',
                                                       glyphicon_name: 'cog'
                                                   })
    CustomizableAdmin::Settings::Menu.create({
                                                       ancestry: '2',
                                                       name: 'Users',
                                                       class_name: 'CustomizableAdmin::Settings::User'
                                                   })
    CustomizableAdmin::Settings::Menu.create({
                                                       ancestry: '2',
                                                       name: 'Roles',
                                                       class_name: 'CustomizableAdmin::Settings::Role'
                                                   })
    CustomizableAdmin::Settings::Menu.create({
                                                       ancestry: '2',
                                                       name: 'Menus',
                                                       class_name: 'CustomizableAdmin::Settings::Menu'
                                                   })
    CustomizableAdmin::Settings::Menu.create({
                                                       ancestry: '2',
                                                       name: 'Permissions',
                                                       class_name: 'CustomizableAdmin::Settings::Permission'
                                                   })
  end
end
