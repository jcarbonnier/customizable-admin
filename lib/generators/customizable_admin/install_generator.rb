require 'rails/generators/base'
# require 'securerandom'

module CustomizableAdmin
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../customizable_admin/templates", __FILE__)

      desc "Creates a Customizable admin initializer and copy locale files to your application."
      class_option :orm

      def copy_initializer
        template "initializer.rb", "config/initializers/customizable_admin.rb"
      end

      # def copy_locale
      #   copy_file "../../../config/locales/en.yml", "config/locales/devise.en.yml"
      # end

      def show_readme
        readme "README" if behavior == :invoke
      end

      def rails_4?
        Rails::VERSION::MAJOR == 4
      end
    end
  end
end
