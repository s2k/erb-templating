require 'erb'
require 'ostruct'

MISSING_CONFIG_MARKER = :config_key_and_value_missing

def render(template, configuration_data)
  config_object = OpenStruct.new(configuration_data)
  config_object.table.default = MISSING_CONFIG_MARKER
  ERB.new(template).result(config_object.instance_eval { binding })
end
