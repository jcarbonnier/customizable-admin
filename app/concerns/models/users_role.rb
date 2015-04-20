require 'active_support/concern'

module Models::UsersRole
  extend ActiveSupport::Concern

  included do
    #----- Associations
    belongs_to :user, class_name: 'CustomizableAdmin::Settings::User'
    belongs_to :role, class_name: 'CustomizableAdmin::Settings::Role'
  end

end
