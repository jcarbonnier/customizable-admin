module Controllers::BreadcrumbController
  extend ActiveSupport::Concern

  included do
    helper_method :add_breadcrumb
  end

  def add_breadcrumb(name, url)
    Rails.logger.debug("Add breadcrumb : #{name}")
    @breadcrumb = [] if (@breadcrumb.blank?)
    @breadcrumb.push({:name => name, :url => url})
  end

end
