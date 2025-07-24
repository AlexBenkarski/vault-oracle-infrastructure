# frozen_string_literal: true

module Fluent::Plugin::OCI
    # a hack to compile dynamic class to access fields, this is a copy from
    # DynamicExpander in https://github.com/repeatedly/fluent-plugin-record-modifier.
    class RecordExpander
      def initialize(param_key, param_value)
        if param_value.include?('${')
          __str_eval_code__ = parse_parameter(param_value)
  
          # Use class_eval with string instead of define_method for performance.
          # It can't share instructions but this is 2x+ faster than define_method in filter case.
          # Refer: http://tenderlovemaking.com/2013/03/03/dynamic_method_definitions.html
          (class << self; self; end).class_eval <<-EORUBY,  __FILE__, __LINE__ + 1
              def expand(tag, time, record)
                #{__str_eval_code__}
              end
          EORUBY
        else
          @param_value = param_value
        end
  
        begin
          # check eval generates wrong code or not
          expand(nil, nil, nil)
        rescue SyntaxError
          raise ConfigError, "Pass invalid syntax parameter : key = #{param_key}, value = #{param_value}"
        rescue
          # Ignore other runtime errors
        end
      end
  
      # default implementation
      def expand(tag, time, record)
        @param_value
      end
  
      def parse_parameter(value)
        num_placeholders = value.scan('${').size
        if num_placeholders == 1
          if value.start_with?('${') && value.end_with?('}')
            return value[2..-2]
          else
            "\"#{value.gsub('${', '#{')}\""
          end
        else
          "\"#{value.gsub('${', '#{')}\""
        end
      end
  
    end
end