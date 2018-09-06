require 'association_count/version'

module AssociationCount
  DEFAULT_DISTINCT = false
  DEFAULT_JOIN_TYPE = :left_outer_joins

  def association_count(counted_model, distinct: DEFAULT_DISTINCT, join_type: DEFAULT_JOIN_TYPE)
    table_name    = self.table_name
    counted_table = counted_model.table_name
    counted_name  = counted_table.singularize
    distinct_sql  = distinct ? 'DISTINCT' : ''

    public_send(join_type, counted_table.to_sym)
      .select("#{table_name}.*, COUNT(#{distinct_sql} #{counted_table}.id) as #{counted_name}_count_raw")
      .group("#{table_name}.id")
  end

  def can_count(model_name, opts = {})
    model_name = model_name.to_s
    reflection = reflections[model_name]
    raise ArgumentError, "No such reflection: '#{model_name}'" unless reflection

    options = {
      distinct: DEFAULT_DISTINCT,
      join_type: DEFAULT_JOIN_TYPE
    }.merge!(opts)
    singular_name = model_name.singularize

    define_association_count_method(model_name, singular_name)
    define_count_scope(singular_name, reflection, options[:distinct], options[:join_type])
  end

  def define_association_count_method(model_name, singular_name)
    define_method "#{singular_name}_count" do
      raw_count_name = "#{singular_name}_count_raw"
      return send(raw_count_name) if self.respond_to?(raw_count_name)
      send(model_name).count
    end
  end

  def define_count_scope(singular_name, reflection, default_distinct, default_join_type)
    scope_name = "include_#{singular_name}_count"
    class_eval do
      scope scope_name, ->(distinct: default_distinct, join_type: default_join_type) {
        association_count(reflection.klass, distinct: distinct, join_type: join_type)
      }
    end
  end
end
