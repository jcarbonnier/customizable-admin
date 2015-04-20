module CustomizableAdmin::Devise
  class UnlocksController < ::Devise::UnlocksController

    layout CustomizableAdmin.cadm_layout # 'customizable_admin/application'
    helper CustomizableAdmin::ApplicationHelper

  end
end
