module CustomizableAdmin::Devise
  class RegistrationsController < ::Devise::RegistrationsController

    helper CustomizableAdmin::ApplicationHelper
    before_filter :configure_permitted_parameters

    #----------------------------------------
    private
    #----------------------------------------

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update).push(:civility, :firstname, :lastname)
    end

  end
end
