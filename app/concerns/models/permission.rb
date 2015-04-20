require 'active_support/concern'

module Models::Permission
  extend ActiveSupport::Concern

  included do

    ##
    # Cancan abilities for models
    #-----
    def self.abilities(model_name)
      default_abilities = %i[manage create read update destroy]
      case model_name.to_s
        when 'CustomizableAdmin::Settings::User'
          return (default_abilities << %i[permissions]).flatten
        when 'CustomizableAdmin::Settings::Permission'
          return (default_abilities << %i[setup_actions_controllers_db]).flatten
        when 'CustomizableAdmin::Settings::Menu'
          return (default_abilities << %i[manage_positions update_positions]).flatten
        else
          return default_abilities
      end
    end

  end
end
