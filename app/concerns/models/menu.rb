require 'active_support/concern'

module Models::Menu
  extend ActiveSupport::Concern

  included do
    has_ancestry
  end

end
