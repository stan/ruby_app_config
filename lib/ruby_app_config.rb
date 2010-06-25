require 'ostruct'
require 'erb'
require 'yaml'

class Object

  def to_ostruct
    return case self
    when Hash
      self.each do |key, value| self[key] = value.to_ostruct end
      OpenStruct.new(self)
    when Array
      self.map! { |i| i.to_ostruct }
    else
      self
    end
  end

end

class Hash

  def deep_merge!(second)
    second.each_pair do |k,v|
      if self[k].is_a?(Hash) and second[k].is_a?(Hash)
        self[k].deep_merge!(second[k])
      else
        self[k] = second[k]
      end
    end
  end

end

class AppConfig

  def self.create(yaml_file, options = {})
    yaml_data = YAML::load(ERB.new(IO.read(yaml_file)).result)
    data = yaml_data["defaults"]
    data.deep_merge!(yaml_data[options[:environment]]) if options[:environment]
    data.to_ostruct
  end

end
