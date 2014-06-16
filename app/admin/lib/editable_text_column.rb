module ActiveAdmin
  module Views
    class IndexAsTable < ActiveAdmin::Component
      def editable_text_column resource, attr
        val = resource.send(attr)
        val = "&nbsp;" if val.blank?

        html = %{
                  <div  id='editable_text_column_#{resource.id}'
                        class='editable_text_column'
                        ondblclick='admin.editable_text_column_do(this)' >
                        #{val}
                   </div>

                   <input

                      data-path='#{resource.class.name.tableize}'
                      data-attr='#{attr}'
                      data-resource-id='#{resource.id}'
                      class='editable_text_column admin-editable'
                      id='editable_text_column_#{resource.id}'

                      style='display:none;' />
              }
        html.html_safe
      end
    end
  end
end