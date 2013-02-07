require 'justools/core_ext/array/merge_options'

module Juscribe
  ARGS_AND_OPTS_REGEXP = /^#{%w(arg(?:ument)?s opt(?:ion)?s).
                             zip(Array.new(2, "(?:_with_(\\w+))?")).
                             map(&:join) * '_and_'}!?$/
end

class Array
  unless Array.instance_methods.include?(:rotate) # Was only patch for 1.8
    def rotate
      self[0..-2].unshift(self[-1])
    end
  end
  
  def arguments_and_options(update_hash = {})
    merge_options(update_hash).args_and_opts!
  end
  
  def arguments_and_options!(update_hash = {})
    [extract_options_with_merge!(update_hash), self].rotate
  end
  
  [:args_and_opts!, :args_and_opts_with_merge!,
                    :arguments_and_options_with_merge!].each do |meth|
    alias_method meth,                    :arguments_and_options!
    alias_method meth.to_s[0..-2].to_sym, :arguments_and_options
  end
  
  # Method#parameters only available in Ruby 1.9+  
  if RUBY_VERSION > '1.9'  
    private 
    def method_missing(method_symbol, *args, &block)
      return super unless method_symbol =~ Justools::ARGS_AND_OPTS_REGEXP
    
      [$1, $2].zip(args_and_opts).map do |m, obj|
        next if m.respond_to?(:empty?) ? empty? : !m
        obj.send(m.to_sym, *args.send(:constrained_by_method, obj.method(m.to_sym)))
      end
    end
    
    def constrained_by_method(methud)    
      methud.parameters.detect { |t, _| t == :rest } or return self
      take([methud.parameters.size, methud.arity.abs].max)
    end
  end
end
