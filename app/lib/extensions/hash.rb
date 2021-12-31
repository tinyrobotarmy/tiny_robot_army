require 'ostruct'

class Hash
  def ostructify
    temp = inject({}) do |hash, (key, value)|
      hash[key.to_s.underscore.to_sym] = (value.is_a?(Hash) || value.is_a?(Array)) ? value.ostructify : value
      hash
    end
    OpenStruct.new temp
  end
end
