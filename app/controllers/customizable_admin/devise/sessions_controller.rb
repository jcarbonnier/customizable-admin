module CustomizableAdmin::Devise
  class SessionsController < Devise::SessionsController

    layout CustomizableAdmin.cadm_layout # 'customizable_admin/application'
    helper CustomizableAdmin::ApplicationHelper
    prepend_before_filter :check_user_confirmation, only: [:create]

    #
    # other code here not relevant to the example
    #

    #----------------------------------------
    private
    #----------------------------------------

    ##
    # Check user confirmation, redirect if not confirmed
    #-----
    def check_user_confirmation
      user = CustomizableAdmin::Settings::User.find_by_email(params[:user][:email])
      if (user && !user.confirmed?)
        flash[:alert] = I18n.t('devise.failure.unconfirmed')
        return redirect_to new_confirmation_path(:user)
      end
    end

  end
end
