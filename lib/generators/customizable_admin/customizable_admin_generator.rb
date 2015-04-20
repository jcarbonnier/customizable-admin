require 'rails/generators/rails/scaffold/scaffold_generator'

class CustomizableAdminGenerator < Rails::Generators::ScaffoldGenerator
end

require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'
require 'rails/generators/resource_helpers'

module Rails
  module Generators
    class ScaffoldControllerGenerator < NamedBase
      source_root File.expand_path('../../../customizable_admin/templates/rails/scaffold_controller', __FILE__)
    end
  end
end

require 'rails/generators/erb/scaffold/scaffold_generator'

module Erb
  module Generators
    class ScaffoldGenerator < Base
      source_root File.expand_path('../../../customizable_admin/templates/erb/scaffold', __FILE__)

      protected

      def available_views
        %w(index edit show new _form _index_items)
      end

    end
  end
end
