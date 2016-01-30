module Gracenote
  module Helper
    def wrap_array(object)
      case object
      when NilClass
        []
      when Array
        object
      else
        [object]
      end
    end

    def recursive_downcase_keys(object, numerify_values: false)
      case object
      when Hash
        object.each_with_object({}) do |(k,v), memo|
          memo[k.downcase] = recursive_downcase_keys(v, numerify_values: numerify_values)
        end
      when Array
        object.map { |e| recursive_downcase_keys(e, numerify_values: numerify_values) }
      else
        numerify_values ? numerify_value(object) : object
      end
    end

    def numerify_value(v)
      if v =~ /^\d+$/
        v.to_i
      else
        v
      end
    end
  end
end
