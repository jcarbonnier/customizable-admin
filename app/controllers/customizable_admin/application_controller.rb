class CustomizableAdmin::ApplicationController < ActionController::Base

  #----- Select layout
  layout CustomizableAdmin.cadm_layout
  #----- Before filters
  before_action :initialize_application
  #----- Helpers
  helper_method :cancan_abilities

  ##
  # Breadcrumb
  #-----
  def add_breadcrumb(name, url)
    Rails.logger.debug("Add breadcrumb : #{name}")
    @breadcrumb = [] if (@breadcrumb.blank?)
    @breadcrumb.push({:name => name, :url => url})
  end

  #----------------------------------------
  protected
  #----------------------------------------

  ##
  # Initialiaze application
  #-----
  def initialize_application(opts = {})
    add_breadcrumb(I18n.t('breadcrumbs.root'), :root)
  end

  # ##
  # # Default layout selection
  # #-----
  # def select_layout
  #   Rails.logger.debug("########## Select layout from customizable admin (AuthorizationsController)")
  #   return 'customizable_admin/application'
  # end

end
