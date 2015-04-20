class CreateCustomizableAdminRoles < ActiveRecord::Migration
  def change
    create_table :cadm_roles do |t|
      t.string :name

      t.timestamps null: false
    end
    # Create default roles
    CustomizableAdmin::Settings::Role.create({name: 'SuperAdmin'})
    CustomizableAdmin::Settings::Role.create({name: 'Admin'})
    CustomizableAdmin::Settings::Role.create({name: 'Technic'})
    CustomizableAdmin::Settings::Role.create({name: 'Marketing'})
    CustomizableAdmin::Settings::Role.create({name: 'Commercial'})
  end
end
