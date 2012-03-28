require 'justools/core_ext'

module Justools
  ARGS_AND_OPTS_REGEXP = /^#{%w(arg(?:ument)?s opt(?:ion)?s).
                             zip(Array.new(2, "(?:_with_(\\w+))?")).
                             map(&:join) * '_and_'}!?$/
end
