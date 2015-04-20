require 'active_support/concern'

module Models::Role
  extend ActiveSupport::Concern

  included do
    #----- Associations
    has_and_belongs_to_many :users, :class_name => 'CustomizableAdmin::Settings::User'
    has_many :permissions_roles, as: :resource, class_name: "CustomizableAdmin::Settings::PermissionsResource"
    has_many :permissions, through: :permissions_roles, class_name: "CustomizableAdmin::Settings::Permission"
    #----- Scopes
    scope :super_admin, -> { where("id=?", 1) }
    scope :admin, -> { where("id=?", 2) }
    scope :technic, -> { where("id=?", 3) }
    scope :marketing, -> { where("id=?", 4) }
    scope :commercial, -> { where("id=?", 5) }
  end

end
