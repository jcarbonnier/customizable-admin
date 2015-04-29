module CustomizableAdmin
  class Settings::PermissionsController < ApplicationController

    # Include needed concerns
    include Controllers::DefaultController
    include Controllers::PrivateController

    ##
    # Setup permissions
    #-----
    def setup_actions_controllers_db
      write_permission("all", "manage", "Everything", "All operations", true)
      @models = ActiveRecord::Base.subclasses.select { |type|
        type.name unless (type.name.match('HABTM'))
      }
      # Rails.logger.debug("Models : #{@models.inspect}")
      @models.each do |mod|
        Rails.logger.debug("Model : #{mod}")
        CustomizableAdmin::Settings::Permission.abilities(mod).each do |ability|
          description = mod.model_name.human
          write_permission(mod, ability, description, "#{ability} operations")
        end
      end
    end

    #----------------------------------------
    protected
    #----------------------------------------

    def initialize_application
      super()
      add_breadcrumb(Settings::Permission.model_name.human.pluralize, :settings_permissions)
      add_breadcrumb(t('breadcrumbs.actions.new'), :new_settings_permissions) if (['new', 'create'].include?(action_name))
      add_breadcrumb("Setup", :setup_actions_controllers_db_permissions) if (['setup_actions_controllers_db'].include?(action_name))
      if (params[:id])
        add_breadcrumb(t('breadcrumbs.actions.show'), settings_permission_path(params[:id]))
        add_breadcrumb(t('breadcrumbs.actions.edit'), edit_settings_permission_path(params[:id])) if (['edit', 'update'].include?(action_name))
      end
    end

    #----------------------------------------
    private
    #----------------------------------------

    def resource_params
      params.require(require_params).permit(:name, :subject_class, :subject_id, :action, :description)
    end

    def require_params
      return :settings_permission
    end

    def sort_column
      return "#{@current_model.table_name}.subject_class, #{@current_model.table_name}.id" unless (params[:sort])
      super()
    end

    ##
    # Translate cancan action to db
    #-----
    def eval_cancan_action(action)
      case action.to_s
        when "index", "show", "search"
          cancan_action = "read"
          action_desc = I18n.t :read
        when "create", "new"
          cancan_action = "create"
          action_desc = I18n.t :create
        when "edit", "update"
          cancan_action = "update"
          action_desc = I18n.t :edit
        when "delete", "destroy"
          cancan_action = "delete"
          action_desc = I18n.t :delete
        else
          cancan_action = action.to_s
          action_desc = "Other: " << cancan_action
      end
      return action_desc, cancan_action
    end

    ##
    # Create permission
    #-----
    def write_permission(class_name, cancan_action, name, description, force_id_1 = false)
      permission = CustomizableAdmin::Settings::Permission.
          where("subject_class = ? and action = ?", class_name, cancan_action).
          first
      if not permission
        permission = CustomizableAdmin::Settings::Permission.new
        permission.id = 1 if force_id_1
        permission.subject_class = class_name
        permission.action = cancan_action
        permission.name = name
        permission.description = description
        permission.save
      else
        permission.name = name
        permission.description = description
        permission.save
      end
    end
  end
end
