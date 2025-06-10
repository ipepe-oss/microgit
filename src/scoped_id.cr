module ScopedId
  extend self

  def set(column : Avram::Attribute(Int64 | Nil), query : Avram::Queryable) : Nil
    set(column, query)
  end

  macro set(column, query)
    return unless {{column}}.value.nil?
    scope = {{query.id}}.{{column.id}}.select_max
    current_max_scoped_id = scope || 0
    id = current_max_scoped_id + 1
    {{column.id}}.value = id.to_i64
  end
end
