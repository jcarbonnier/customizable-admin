require 'active_support/concern'

module Controllers::PrivateController
  extend ActiveSupport::Concern

  included do
    #----- CanCan check authorization
    authorize_resource instance_name: :item, collection: :items, except: [:home]

    #----- Rescue unauthorized access
    self.rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_path, :alert => exception.message
    end
  end

end
