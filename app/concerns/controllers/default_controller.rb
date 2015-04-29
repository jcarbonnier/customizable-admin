require 'active_support/concern'

module Controllers::DefaultController
  extend ActiveSupport::Concern

  included do
    #----- Filters
    before_action :initialize_application
    #----- CanCan load resource
    load_and_authorize_resource instance_name: :item, collection: :items, except: [:home]
    #----- Helper methods
    helper_method :initialize_application
    helper_method :index, :show, :new, :edit, :create, :update, :destroy
    helper_method :manage_positions, :update_positions
    helper_method :require_params, :configure_permitted_parameters
    helper_method :sort_column, :sort_direction, :default_sort_column, :default_sort_direction
    helper_method :check_parameters
    #----- Responses formats
    respond_to :html, :xml, :json, :js, :xls
  end

  # ##
  # # Rescue access denied exception
  # #-----
  # rescue_from CanCan::AccessDenied do |exception|
  #   redirect_to root_path, :alert => exception.message
  # end

  # ##
  # # Default url options, adding locale to link_to
  # #-----
  # def default_url_options(options = {})
  #   {}
  #   # {locale: I18n.locale}.merge options
  # end

  ##
  # Index action view
  #-----
  def index(opts = {})
    @default_attrs ||= {}
    @current_model.column_names.each { |attr|
      @default_attrs[attr] ||= params[@current_item_name][attr] if (params[@current_item_name] and params[@current_item_name][attr])
      @default_attrs[attr] ||= session['filters'][@current_item_name][attr] if (session['filters'][@current_item_name] and session['filters'][@current_item_name][attr])
      @default_attrs[attr] ||= nil
    }
    @items = @items.
        includes(@includes).
        search(@default_attrs).
        order("#{sort_column} #{sort_direction}").
        paginate(:page => params[:page], :per_page => params[:per_page])
    respond_to do |format|
      format.js { render template: 'layouts/index' }
      format.json { render :json => @items }
      format.xml { render :xml => @items }
      format.xls {
        headers['Content-Disposition'] = "attachment; filename=export_#{Date.today}_#{Time.now.hour}#{Time.now.min}#{Time.now.sec}.xls"
        headers['Cache-Control'] = ''
        render 'layouts/customizable_admin/application.xls'
      }
      format.html
    end
  end

  def show(opts = {})
    respond_with(@item) unless (opts[:skip_response])
  end

  def new(opts = {})
    respond_with(@item) unless (opts[:skip_response])
  end

  def edit
  end

  def create(opts = {})
    @item.save
    respond_with(@item) unless (opts[:skip_response])
  end

  def update(opts = {})
    @item.update(resource_params)
    respond_with(@item) unless (opts[:skip_response])
  end

  def destroy
    @item.destroy
    respond_with(@item)
  end

  ##
  # Manage positions for sortable lists
  #-----
  def manage_positions(opts = {})
    @items = @items.
        includes(@includes).
        search(@default_attrs).
        order(:position)
    respond_to do |format|
      format.html { render 'layouts/customizable_admin/manage_positions' }
      format.json { render :json => @items }
      format.xml { render :xml => @items }
    end
  end

  def update_positions()
    Rails.logger.debug("Update positions !")
    @result = {:error => false, :message => 'ok'}
    # Update positions
    params[:sortable_list].each do |sortable_list|
      item = @current_model.find(sortable_list[:ids])
      item.position = sortable_list[:positions]
      item.save
    end
    # Update left and right boundaries
    # items = @current_model.where('parent_id IS NULL').order('position')
    # self.updateChildrenBoundaries(items, 1)
    # Select items
    @items = @items.
        includes(@includes).
        search(@default_attrs).
        order(:position)
    # Render items
    render({
               :partial => 'customizable_admin/partials/manage_positions_item',
               :collection => @items.select { |i| (i.is_root?) },
               :locals => {:depth => 0}
           },
           :layout => nil)
  end

  #----------------------------------------
  protected
  #----------------------------------------

  ##
  # Initialiaze application
  #-----
  def initialize_application(opts = {})
    Rails.logger.debug("Admin::Application initialize")
    @paths = controller_path.gsub(customizable_admin.root_url, '').split('/')
    @current_model_name = @paths.collect { |item| item.camelize }.join('::').classify
    @current_item_name = require_params
    @current_model = @current_model_name.safe_constantize
    # Rails.logger.debug("@current_model_name: #{@current_model_name}")
    # Rails.logger.debug("@current_item_name: #{@current_item_name}")
    # Rails.logger.debug("@current_model: #{@current_model}")
    # Initialize filters
    session['filters'] = {} unless (session['filters'])
    if ((action_name == 'index' and !params[@current_item_name].blank?))
      session['filters'][@current_item_name] = {}
      session['filters'][@current_item_name] = params[@current_item_name].delete_if { |k, v| v.blank? }
    end
    session['filters'].each do |c_name, value|
      if (c_name != @current_item_name and params[:keep_filters].blank?)
        logger.debug("FLUSH session['filters'][#{c_name}]")
        session['filters'][c_name].clear unless (session['filters'][c_name].nil?)
        session['filters'].delete(c_name)
      end
    end
    super()
  end

  ##
  # Default require params method
  #-----
  def require_params
    return nil
  end

  ##
  # Configure permitted parameters for devise
  #-----
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :pseudonym
    devise_parameter_sanitizer.for(:account_update) << :pseudonym
  end

  ##
  # Sort columns
  #-----
  def sort_column
    return "#{@current_model.table_name}.#{default_sort_column()}" unless (params[:sort])
    (t_name, c_name) = (params[:sort].index('.')) ?
        params[:sort].split('.') :
        "#{@current_model.table_name}.#{params[:sort]}".split('.')
    @current_model.column_names.include?(c_name) ? "#{t_name}.#{c_name}" : "#{@current_model.table_name}.#{default_sort_column()}"
  end

  ##
  # Sort direction
  #-----
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : default_sort_direction()
  end

  ##
  #
  #-----
  def default_sort_column()
    return 'id'
  end

  ##
  #
  #-----
  def default_sort_direction()
    return 'asc'
  end

  ##
  # Check sent parameters
  #-----
  def check_parameters(ps = [])
    for p in ps
      raise Exceptions::RequestedParameterException, t('requests.missing_parameter', :p_name => p) if (params[p].blank?)
    end
  end

end