require 'active_support/concern'

module Models::PermissionsResource
  extend ActiveSupport::Concern

  included do
    #----- Associations
    belongs_to :permission, class_name: 'CustomizableAdmin::Settings::Permission'
    belongs_to :resource, polymorphic: true
  end

end
