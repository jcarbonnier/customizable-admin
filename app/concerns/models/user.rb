require 'active_support/concern'

module Models::User
  extend ActiveSupport::Concern

  included do
    #----- Devise. Others available are: :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
    #----- Associations
    has_and_belongs_to_many :roles, :class_name => 'CustomizableAdmin::Settings::Role'
    has_many :permissions_roles, through: :roles, :class_name => 'CustomizableAdmin::Settings::PermissionsResource'
    has_many :permissions_users, as: :resource, class_name: "CustomizableAdmin::Settings::PermissionsResource"
    has_many :permissions, through: :permissions_users, :class_name => 'CustomizableAdmin::Settings::Permission'
    #----- Validations
    validates :email, presence: true, uniqueness: true

    ##
    # Check if user has role
    #-----
    def has_role?(role)
      roles.include?(role)
    end

    ##
    # All user permissions (role + specific)
    #-----
    def all_permissions
      list = []
      list << permissions_roles.collect { |p| p.permission }
      list << permissions_users.collect { |p| p.permission }
      return list.flatten
    end
  end

end
