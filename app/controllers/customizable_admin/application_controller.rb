class CustomizableAdmin::ApplicationController < ActionController::Base

  #----- Include concerns
  include Controllers::BreadcrumbController
  #----- Select layout
  layout CustomizableAdmin.cadm_layout
  #----- Before filters
  before_action :initialize_application
  #----- Helpers
  helper_method :cancan_abilities

  #----------------------------------------
  protected
  #----------------------------------------

  ##
  # Initialiaze application
  #-----
  def initialize_application(opts = {})
    add_breadcrumb(I18n.t('breadcrumbs.root'), :root)
  end

end
