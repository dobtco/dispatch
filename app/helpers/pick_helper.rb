module PickHelper
  def pick(obj, *keys)
    stringified_keys = keys.map(&:to_s)

    {}.tap do |h|
      if obj.is_a?(Hash)
        obj.each do |key, value|
          h[key.to_sym] = value if stringified_keys.include?(key.to_s)
        end
      else
        stringified_keys.each do |key|
          if obj.respond_to?(key)
            h[key.to_sym] = obj.send(key)
          end
        end
      end
    end
  end
end
