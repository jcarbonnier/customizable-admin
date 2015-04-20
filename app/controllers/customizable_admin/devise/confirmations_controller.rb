module CustomizableAdmin::Devise
  class ConfirmationsController < ::Devise::ConfirmationsController

    layout CustomizableAdmin.cadm_layout # 'customizable_admin/application'
    helper CustomizableAdmin::ApplicationHelper

  end
end
