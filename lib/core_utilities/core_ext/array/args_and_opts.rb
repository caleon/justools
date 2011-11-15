class Array
  def arguments_and_options(update_hash={})
    merge_options(update_hash).args_and_opts!
  end
  
  def arguments_and_options!(update_hash={})
    [ extract_options_with_merge!(update_hash), self ].rotate
  end
  [ :args_and_opts!, :args_and_opts_with_merge!, :arguments_and_options_with_merge! ].each do |meth|
    alias_method meth[0..-2].intern, :arguments_and_options
    alias_method meth,               :arguments_and_options!
  end
  
  # duplicated logic from argumentation
  def constrained_by_archetype_and_method(archetype, method_name)
    # all_proc = lambda { |type, m| type != :rest }
    limit = [ archetype.method(method_name).parameters.if?(".all? { |type, m| type != :rest }", :else => (1.0/0)).count,
              archetype.method(method_name).arity.abs ].max
    take(limit.unless?(:finite?) { self.size })
  rescue
    self
  end
  
  private 
  def method_missing(method_sym, *arguments, &block)
    return super unless Object.const_defined?(:REGEX) and method_sym =~ /^#{%w(arg(?:ument)?s opt(?:ion)?s).zip(Array.new(2, ::REGEX[:with_method_name].source)).map(&:join).join('_and_')}!$/
    args_and_opts.tap do |argopts|
      [ $1, $2 ].each_with_index do |meth, i|
        next unless meth.significant?
        params = (that_meth = (obj = argopts[-i]).method(meth.intern)).parameters
        argopts[-i] = (meth && obj.if?([ :respond_to?, meth.intern ]).send(*(i == 0 ? meth.intern : [ meth.intern, *arguments.constrained_by_archetype_and_method(obj, meth) ])))
      end
    end # end args_and_opts.tap
  end
end
