require 'justools/core_ext/array/flatten_splat'

class Object
  
  # === Examples
  #
  #   { :a=>1, .., :z=>26 }.as { |h| h.each { |k, v| h[k] = v + h[26 - v] } }
  #
  #   User.find(15).stories.joins(:tasks).as { |s| [s.class.to_s, s.count] }.
  #        as { |klass_name, count| "#{count} stories in #{klass_name}" }
  #
  #   [15, { :includes => { :stories => :tasks } }, 56, 78, 102].
  #        as { |id, opts, *ns| ns.each { |n| puts n }; User.find(id, opts) }
  def as(&block)
    yield self
  end
  
  # === Examples
  #
  #   user = User.find_by_id(10).or_else { |res| raise "Got back #{res}" }
  def or_else(&block)
    self || yield(self)
  end
  
  # === Examples
  #
  #   authorization = User.find_by_id(10).and_also { |u| u.authorization }
  def and_also(&block)
    self && yield(self)
  end
  
  # unless Object.method_defined?(:in?)
    # Copy of Object#in? from Rails 3.2.1 which also allows list.
    #
    # === Parameters
    #
    # * +args+ - Array or a list of its contents.
    def in?(*args)
      if args.length > 1
        args.include? self
      else
        another_object = args.first
        if another_object.respond_to? :include?
          another_object.include?(self)
        else
          raise ArgumentError.new("The single parameter passed to #in? must respond to #include?")
        end
      end
    end
  # end
  # def is_included_in?(*others) #d deprecated
  #   others.flatten_splat.include?(self)
  # end
  alias_method :is_included_in?, :in?
  
  def out_of?(*others)
    others.flatten_splat.exclude?(self)
  end
  alias_method :is_excluded_from?, :out_of?

  # Similar to is_a? or kind_of? but with an array of possible classes.
  # Returns the matching class or a nil.
  #
  # === Parameters
  #
  # * +klasses+ - List of Class constants, or an Array of Class constants.
  #
  # === Examples
  #
  #   rec_or_num.one_kind_of?(User, Admin).or_else { User.find(rec_or_num) }
  def one_kind_of?(*klasses)
    klasses.flatten_splat.detect { |klass| self.kind_of?(klass) }
  end
  alias_method :is_one_kind_of?, :one_kind_of?
  
  # Similar to is_a? or kind_of? but with an array of possible classes.
  # Returns the matching class or a nil. Renamed here from is_one_kind_of?
  # because it uses the 'klass === self' which isn't necessarily equivalent to
  # 'self.is_a?(klass)'.
  #
  # === Parameters
  #
  # * +args+ - List of arguments.
  #
  # === Examples
  #
  #   rec_or_num.one_of?(User, Admin).or_else { User.find(rec_or_num) }
  def one_of?(*args)
    args.flatten_splat.detect { |arg| arg === self}
  end
  alias_method :is_when?, :one_of?
end
