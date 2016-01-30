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

    def recursive_downcase_keys(hash, numerify_values: false)
      hash.each_with_object({}) do |(k,v), memo|
        memo[k.downcase] = case v
        when Hash
          recursive_downcase_keys(v)
        when Array
          v.map do |e|
            case e
            when Hash
              recursive_downcase_keys(e)
            else
              e
            end
          end
        else
          if numerify_values && v =~ /^\d+$/
            v.to_i
          else
            v
          end
        end
      end
    end
  end
end
