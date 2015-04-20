require 'rails/generators/rails/scaffold/scaffold_generator'

class CustomizableAdminGenerator < Rails::Generators::ScaffoldGenerator
end

require 'rails/generators/erb/scaffold/scaffold_generator'

module Erb
  module Generators
    class ScaffoldGenerator < Base

      protected

      def available_views
        %w(index edit show new _form _index_items)
      end

    end
  end
end
