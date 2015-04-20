module CustomizableAdmin
  class Settings::MenusController < AuthorizationsController

    #----------------------------------------
    protected
    #----------------------------------------

    ##
    # Sort columns
    #-----
    def sort_column
      return "position"
    end

    ##
    # Initialiaze application
    #-----
    def initialize_application
      super()
      add_breadcrumb(Settings::Menu.model_name.human.pluralize, :settings_menus)
      add_breadcrumb(t('breadcrumbs.actions.new'), :new_settings_menus) if (['new', 'create'].include?(action_name))
      add_breadcrumb(t('breadcrumbs.actions.manage_positions'), :settings_menus) if (['manage_positions'].include?(action_name))
      if (params[:id])
        add_breadcrumb(t('breadcrumbs.actions.show'), settings_menu_path(params[:id]))
        add_breadcrumb(t('breadcrumbs.actions.edit'), edit_settings_menu_path(params[:id])) if (['edit', 'update'].include?(action_name))
      end
    end

    #----------------------------------------
    private
    #----------------------------------------

    def resource_params
      params.require(require_params).permit(:parent_id, :name, :class_name, :glyphicon_name)
    end

    def require_params
      return :settings_menu
    end
  end
end
