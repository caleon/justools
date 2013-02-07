require 'justools/core_ext/array/flatten_splat'

class Object
  
  # === Examples
  #
  #   { :a=>1, .., :z=>26 }.aka { |h| h.each { |k, v| h[k] = v + h[26 - v] } }
  #
  #   User.find(15).stories.joins(:tasks).aka { |s| [s.class.to_s, s.count] }.
  #        aka { |klass_name, count| "#{count} stories in #{klass_name}" }
  #
  #   [15, { :includes => { :stories => :tasks } }, 56, 78, 102].
  #        aka { |id, opts, *ns| ns.each { |n| puts n }; User.find(id, opts) }
  def aka(&block)
    yield self
  end
end
