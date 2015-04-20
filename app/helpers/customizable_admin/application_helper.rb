module CustomizableAdmin
  module ApplicationHelper

    ##
    # Breadcrumb rendering
    #-----
    def render_breadcrumbs()
      return nil if (@breadcrumb.blank?)
      lis = ""
      last_index = @breadcrumb.length - 1
      @breadcrumb.each_with_index do |bc, index|
        Rails.logger.debug("#{index} vs #{last_index}")
        if (index == last_index)
          lis << content_tag(:li, bc[:name], :class => 'active')
        else
          lis << content_tag(:li, link_to(bc[:name], bc[:url]))
        end
      end
      content_tag(:ol, :class => 'breadcrumb') do
        raw(lis)
      end
    end

    ##
    # Bootstrap flash messages
    #-----
    def bootstrap_flash(opts = {})
      options = {
          :text => flash[:alert] ? flash[:alert] : flash[:notice] ? flash[:notice] : nil,
          :class => (flash[:alert]) ? 'alert alert-danger alert-dismissible' :
              (flash[:notice]) ? 'alert alert-info alert-dismissible' : 'alert alert-dismissible'
      }.merge!(opts)
      return nil if (options[:text].blank?)
      content_tag(:div, :class => options[:class]) do
        concat(content_tag(:button, type: "button", class: "close", 'data-dismiss' => "alert") do
                 concat(content_tag(:span, raw("&times;"), 'aria-hidden' => "true"))
                 concat(content_tag(:span, "close", class: 'sr-only'))
               end)
        concat(options[:text])
      end
    end

    ##
    # Show glyphicon
    #-----
    def glyphicon(name, *others)
      gi = "glyphicon glyphicon-#{name.to_s.gsub('_', '-')} "
      gi += others.collect { |other| other.to_s }.join(" ")
      content_tag(:i, nil, :class => gi)
    end

    ##
    # Set a label with succes or not
    #-----
    def glyphicon_checked(checked)
      return glyphicon(:ok, checked ? 'text-success' : 'text-danger')
    end

    ##
    # Sortable columns
    #-----
    def sortable(column, title = nil)
      (table_name, column_name) = (column.index('.')) ? column.split('.') : "#{@current_model.table_name}.#{column}".split('.')
      cur_model = @current_model
      title ||= cur_model.human_attribute_name(column_name)
      is_current = (table_name == sort_column.split('.').first and column_name == sort_column.split('.').last)
      css_class = is_current ? "active #{sort_direction}" : nil
      direction = is_current && sort_direction == "asc" ? "desc" : "asc"
      if (is_current)
        title += " " + ((direction == 'asc') ? glyphicon(:chevron_down) : glyphicon(:chevron_up))
      end
      link_to raw(title), params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
    end

    ##
    # Custom format of pagination
    #-----
    def custom_paginate(items, options = {})
      opts = {
          :renderer => PaginateLinkRenderer,
          :inner_window => 2,
          :class => 'pagination pagination-sm',
          :previous_label => raw(glyphicon(:chevron_left)), #t('will_paginate.previous_label'),
          :next_label => raw(glyphicon(:chevron_right)) # t('will_paginate.next_label')
      }.merge(options)
      return will_paginate(items, opts)
    end

    ##
    # Link for associations
    #-----
    def link_to_add_association(name, form, association, options = {})
      opts = {
          target: ".fields_#{association}",
          link_class: 'btn btn-xs btn-success pull-right has-tooltip',
          title: "#{name}",
          sortable: false,
          index: nil,
          child_index: ''
      }.merge!(options)
      Rails.logger.info(form.object.to_yaml)
      new_object = form.object.class.reflect_on_association(association).klass.new
      template_path = @paths.join('/') + '/form/' + association.to_s.singularize
      fields = form.fields_for(association, new_object, :child_index => opts[:child_index]) do |builder|
        render(:partial => template_path, :locals => {:f => builder, :new_id => "new_id"})
      end
      link_to(name, '#', {onclick: h("add_association(this, '#{opts[:target]}', '#{association}', '#{escape_javascript(fields)}', false); $('.chosen').chosen({allow_single_deselect: true}); return false"), class: opts[:link_class]})
      # opts = {
      #     target: ".fields_#{association}",
      #     link_class: 'btn btn-xs btn-success pull-right has-tooltip',
      #     title: "test #{name}",
      #     sortable: false,
      #     index: nil,
      #     child_index: "new_#{association}"
      # }.merge!(options)
      # new_object = form.object.class.reflect_on_association(association).klass.new
      # template_path = association.to_s.singularize
      # fields = form.fields_for(association, new_object, child_index: opts[:child_index]) do |builder|
      #   render(:partial => template_path, :locals => {:f => builder})
      # end
      # link_to_function(name, "add_association('#{opts[:target]}', '#{association}', '#{escape_javascript(fields)}', false)", {:class => opts[:link_class]})
    end

    ##
    # Remove linked fields
    #-----
    def link_to_remove_association(name, f, options = {})
      content_tag(:div, class: 'clearfix') do
        content_tag(:p, class: 'pull-right') do
          f.hidden_field(:_destroy) +
              link_to(name, '#', {onclick: h("remove_fields(this, #{f.object.new_record?()}, '#{I18n.locale}'); return false;"), class: 'btn btn-xs btn-danger'})
        end
      end
    end

    # ##
    # # Show popularity stars
    # #-----
    # def glyphicon_stars(nbr, max = 5)
    #   str = glyphicon(:star, 'text-danger') * nbr
    #   str += glyphicon(:star_empty) * (max - nbr)
    #   return str
    # end
    #
    # ##
    # # Set a label with succes or not
    # #-----
    # def glyphicon_checked(checked)
    #   return raw(content_tag(:span, glyphicon(:ok), :class => checked ? 'label label-success' : 'label label-danger'))
    # end
    #
    # ##
    # # Progress bar
    # #-----
    # def progress(percent, label = nil)
    #   label = "#{percent}%" if (label.nil?)
    #   added_class = "progress-bar-#{progress_class(percent)}"
    #   content_tag(:div, class: "progress") do
    #     content_tag(:div, class: "progress-bar #{added_class}", role: "progressbar", 'aria-valuenow' => percent, 'aria-valuemin' => "0", 'aria-valuemax' => "100", style: "width: #{percent}%;") do
    #       "#{label}"
    #     end
    #   end
    # end

    # ##
    # # Form columns
    # #-----
    # def form_cols()
    #   return 'col-sm-12 col-md-8 col-md-offset-2'
    # end

  end

end
