module CustomizableAdmin
  class Settings::UsersController < ApplicationController

    # Include needed concerns
    include Controllers::DefaultController
    include Controllers::PrivateController

    ##
    # Set custom permissions for the user
    #-----
    def permissions
      @permissions = (@item.id == 1) ?
          CustomizableAdmin::Settings::Permission.
              where("#{CustomizableAdmin::Settings::Permission.table_name}.id=1") :
          CustomizableAdmin::Settings::Permission.
              where("#{CustomizableAdmin::Settings::Permission.table_name}.id!=1")
    end

    #----------------------------------------
    protected
    #----------------------------------------

    ##
    # Initialiaze application
    #-----
    def initialize_application
      super()
      add_breadcrumb(Settings::User.model_name.human.pluralize, :settings_users)
      add_breadcrumb(t('breadcrumbs.actions.new'), :new_settings_users) if (['new', 'create'].include?(action_name))
      if (params[:id])
        add_breadcrumb(t('breadcrumbs.actions.show'), settings_user_path(params[:id]))
        add_breadcrumb(t('breadcrumbs.actions.edit'), edit_settings_user_path(params[:id])) if (['edit', 'update'].include?(action_name))
        add_breadcrumb(t('breadcrumbs.actions.manage_permissions'), permissions_settings_user_path(params[:id])) if (['permissions'].include?(action_name))
      end
    end

    #----------------------------------------
    private
    #----------------------------------------

    def resource_params
      if params[require_params][:password].blank?
        params[require_params].delete(:password)
        params[require_params].delete(:password_confirmation)
      end
      params.require(require_params).permit(:email, :password, :password_confirmation, :civility, :firstname, :lastname, :pseudonym, {role_ids: [], permission_ids: []})
    end

    def require_params
      return :settings_user
    end
  end
end
