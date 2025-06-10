module AvramScopedId
  extend self

  def set(column : Avram::Attribute(Int64 | Nil), query : Avram::Queryable) : Nil
    return unless column.value.nil?
    id = next_scoped_id(query)
    column.value = id.to_i64
  end

  private def next_scoped_id(query : Avram::Queryable)
    current = query.scoped_id.select_max || 0
    current + 1
  end
end
