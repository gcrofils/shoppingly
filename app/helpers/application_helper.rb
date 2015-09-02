module ApplicationHelper
  def is_chinese_locale?
    I18n.locale.eql?(:'zh-CN')
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "").gsub(/[[:space:]]+/, " ")})
  end
  
  def date_long_or_words(date)
    date < 15.days.ago ? I18n.l(date, format: :long) : distance_of_time_in_words(date, Time.now)
  end
  
  def errors_for(object)
      if object.errors.any?
          content_tag(:div, class: "panel panel-danger") do
              concat(content_tag(:div, class: "panel-heading") do
                  concat(content_tag(:h4, class: "panel-title") do
                      concat "#{pluralize(object.errors.count, "error")} prohibited this #{object.class.name.downcase} from being saved:"
                  end)
              end)
              concat(content_tag(:div, class: "panel-body") do
                  concat(content_tag(:ul) do
                      object.errors.full_messages.each do |msg|
                          concat content_tag(:li, msg)
                      end
                  end)
              end)
          end
      end
  end

end
