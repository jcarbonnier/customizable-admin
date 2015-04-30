require "customizable_admin/engine"

module CustomizableAdmin

  # Default layout to use with CustomizableAdmin
  mattr_accessor :cadm_layout
  @@cadm_layout = 'customizable_admin/application'

  mattr_accessor :devise_layout
  @@devise_layout = 'customizable_admin/application'

  mattr_accessor :devise_can_sign_up
  @@devise_can_sign_up = true

  # 401 unauthorized redirect subdomain used by Devise
  mattr_accessor :cadm_subdomain
  @@cadm_subdomain = nil

  # Default way to setup Customizable Admin.
  # Run rails generate devise_install to create a fresh initializer with all configuration values.
  def self.setup
    yield self
  end

end
