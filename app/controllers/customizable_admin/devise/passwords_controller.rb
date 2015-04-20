module CustomizableAdmin::Devise
  class PasswordsController < ::Devise::PasswordsController

    layout CustomizableAdmin.cadm_layout # 'customizable_admin/application'
    helper CustomizableAdmin::ApplicationHelper

  end
end
