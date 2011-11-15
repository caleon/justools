%w(object enumerable set array hash).each do |file|
  require File.expand_path("../core_ext/#{file}", __FILE__)
end

require 'core_utilities/core_ext/object'
require 'core_utilities/core_ext/enumerable'
require 'core_utilities/core_ext/set'
require 'core_utilities/core_ext/array'
require 'core_utilities/core_ext/hash'