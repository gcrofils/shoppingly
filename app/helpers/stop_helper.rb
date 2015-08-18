module StopHelper
  def stop_fields_template(f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    haml_tag "#stop_fields_template", data: {id: id, fields: fields.gsub("\n", "").gsub(/[[:space:]]+/, " ")}
  end
end