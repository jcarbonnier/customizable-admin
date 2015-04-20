module CustomizableAdmin
  class Settings::RolesController < AuthorizationsController

    ##
    #
    #-----
    def new
      initialize_permissions()
      super()
    end

    ##
    #
    #-----
    def edit
      initialize_permissions()
      super()
    end

    ##
    #
    #-----
    def update
      initialize_permissions()
      super()
    end

    ##
    #
    #-----
    def show
      initialize_permissions()
      super()
    end

    #----------------------------------------
    protected
    #----------------------------------------

    ##
    # Initialiaze application
    #-----
    def initialize_application
      super()
      add_breadcrumb(Settings::Role.model_name.human.pluralize, :settings_roles)
      add_breadcrumb(t('breadcrumbs.actions.new'), :new_settings_roles) if (['new', 'create'].include?(action_name))
      if (params[:id])
        add_breadcrumb(t('breadcrumbs.actions.show'), settings_role_path(params[:id]))
        add_breadcrumb(t('breadcrumbs.actions.edit'), edit_settings_role_path(params[:id])) if (['edit', 'update'].include?(action_name))
        add_breadcrumb(Settings::Permission.model_name.human.pluralize, permissions_role_path(params[:id])) if (['permissions'].include?(action_name))
      end
    end

    #----------------------------------------
    private
    #----------------------------------------

    def initialize_permissions()
      @permissions = (@item.id == 1) ?
          Settings::Permission.select("#{Settings::Permission.table_name}.*").where("id=1").order("#{Settings::Permission.table_name}.subject_class, #{Settings::Permission.table_name}.id") :
          Settings::Permission.select("#{Settings::Permission.table_name}.*").where("id!=1").order("#{Settings::Permission.table_name}.subject_class, #{Settings::Permission.table_name}.id")
    end

    def resource_params
      params.require(require_params).permit(:name, :roles_permissions, {permission_ids: []})
    end

    def require_params
      return :settings_role
    end

  end
end
