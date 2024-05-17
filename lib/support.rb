require 'erb'

def render(template, configuration_data)
  ERB.new(template).result_with_hash(configuration_data)
end
