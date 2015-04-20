<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController

  #----------------------------------------
  protected
  #----------------------------------------

  ##
  # Initialiaze application
  #-----
  def initialize_application
    super()
    add_breadcrumb(<%= class_name %>.model_name.human.pluralize, :<%= plural_table_name %>)
    add_breadcrumb(t('breadcrumbs.actions.new'), :new_<%= plural_table_name %>) if (['new', 'create'].include?(action_name))
    if (params[:id])
      add_breadcrumb(t('breadcrumbs.actions.show'), <%= singular_table_name %>_path(params[:id]))
      add_breadcrumb(t('breadcrumbs.actions.edit'), edit_<%= singular_table_name %>_path(params[:id])) if (['edit', 'update'].include?(action_name))
    end
  end

  #----------------------------------------
  private
  #----------------------------------------

  def resource_params
    params.require(require_params).permit(<%= attributes.collect {|attr| ':' + attr.column_name}.join(', ') %>)
  end

  def require_params
    return :<%= singular_table_name %>
  end
end
<% end -%>
