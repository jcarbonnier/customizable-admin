# Use this setup block to configure all options available in SimpleForm.

class SimpleForm::Inputs::DatetimePickerInput < SimpleForm::Inputs::StringInput
end

class SimpleForm::Inputs::DatePickerInput < SimpleForm::Inputs::StringInput
end

inputs = %w[
  CollectionSelectInput
  DateTimeInput
  DatetimePickerInput
  DatePickerInput
  FileInput
  GroupedCollectionSelectInput
  NumericInput
  PasswordInput
  RangeInput
  StringInput
  TextInput
]

inputs.each do |input_type|
  superclass = "SimpleForm::Inputs::#{input_type}".constantize
  new_class = Class.new(superclass) do
    def input_html_classes
      case self.class.name
        when 'CollectionSelectInput', 'GroupedCollectionSelectInput'
          super.push('form-control chosen')
        when 'DatePickerInput'
          super.push('form-control date_picker')
        when 'DateTimePickerInput'
          super.push('form-control datetime_picker')
        else
          super.push('form-control')
      end
    end
  end
  Object.const_set(input_type, new_class)
end

SimpleForm.setup do |config|

  config.wrappers :horizontal, tag: 'div', class: 'form-group', error_class: 'has-error',
                  defaults: {
                      input_html: {class: 'default-class '},
                      wrapper_html: {class: "col-lg-12 col-md-12"}
                  } do |b|
    b.use :html5
    b.use :min_max
    b.use :maxlength
    b.use :placeholder
    b.optional :pattern
    b.optional :readonly
    b.use :label
    b.wrapper :right_column, tag: :div, class: 'col-sm-8' do |ba|
      ba.use :input
      ba.use :hint, wrap_with: {tag: :p, class: "help-block"}
      ba.use :error, wrap_with: {tag: :span, class: "help-block text-danger"}
    end
  end

  # Horizontal without label
  config.wrappers :horizontal_wl, tag: 'div', class: 'form-group', error_class: 'has-error',
                  defaults: {
                      input_html: {class: 'default-class '},
                      wrapper_html: {class: "col-lg-12 col-md-12"}
                  } do |b|
    b.use :html5
    b.use :min_max
    b.use :maxlength
    b.use :placeholder
    b.optional :pattern
    b.optional :readonly
    b.wrapper :right_column, tag: :div, class: 'col-sm-12' do |ba|
      ba.use :input
      ba.use :hint, wrap_with: {tag: :p, class: "help-block"}
      ba.use :error, wrap_with: {tag: :span, class: "help-block text-danger"}
    end
  end

  # Inline input
  config.wrappers :inline, :class => 'form-group', :error_class => :error do |b|
    b.use :html5
    b.use :min_max
    b.use :maxlength
    b.use :placeholder
    # b.use :label, wrap_with: {class: 'sr-only'}
    b.use :input
  end

  config.wrappers :stacked, :class => "clearfix", :error_class => :error do |b|
    b.use :placeholder
    b.use :label
    b.use :hint, :wrap_with => {:tag => :span, :class => :'help-block'}
    b.wrapper :tag => 'div', :class => 'input' do |input|
      input.use :input
      input.use :error, :wrap_with => {:tag => :span, :class => :'help-inline'}
    end
  end

  config.wrappers :prepend, :class => "clearfix", :error_class => :error do |b|
    b.use :placeholder
    b.use :label
    b.use :hint, :wrap_with => {:tag => :span, :class => :'help-block'}
    b.wrapper :tag => 'div', :class => 'input' do |input|
      input.wrapper :tag => 'div', :class => 'input-prepend' do |prepend|
        prepend.use :input
      end
      input.use :error, :wrap_with => {:tag => :span, :class => :'help-inline'}
    end
  end

  config.wrappers :append, :class => "clearfix", :error_class => :error do |b|
    b.use :placeholder
    b.use :label
    b.use :hint, :wrap_with => {:tag => :span, :class => :'help-block'}
    b.wrapper :tag => 'div', :class => 'input' do |input|
      input.wrapper :tag => 'div', :class => 'input-append' do |append|
        append.use :input
      end
      input.use :error, :wrap_with => {:tag => :span, :class => :'help-inline'}
    end
  end

  # Wrappers for forms and inputs using the Twitter Bootstrap toolkit.
  # Check the Bootstrap docs (http://twitter.github.com/bootstrap)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  config.input_class = "form-control"
  config.label_class = 'control-label col-sm-4'
  config.default_wrapper = :horizontal

end
