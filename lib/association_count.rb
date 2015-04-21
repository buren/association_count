require "association_count/version"
require 'active_record'

ActiveRecord::Base.extend AssociationCount
module AssociationCount
  def association_count(counted_model)
    proc do |base_model, counted_model|
      table_name    = base_model.table_name
      counted_table = counted_model.table_name
      counted_name  = counted_table.singularize
      
      joins(counted_table.to_sym).
      select("#{table_name}.*, COUNT(#{counted_table}.id) as #{counted_name}_count_raw").
      group("#{table_name}.id")
    end.call(self, counted_model)
  end

  def can_count(model_name)
    model_name = model_name.to_s
    raise 'No such reflection' unless reflection = reflections[model_name.to_s]
    singular_name = model_name.singularize
    define_method "#{singular_name}_count" do
      return send("#{singular_name}_count_raw") if self.respond_to?("#{singular_name}_count_raw")
      send(model_name).count
    end
    class_eval do
      scope "include_#{singular_name}_count", -> { association_count(reflection.klass) }
    end
  end
end
