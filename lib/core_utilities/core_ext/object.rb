class Object
  def as(&block)
    yield self
  end
  
  # Logic utilities
  def or_else(&block)
    self || yield(self)
  end
  
  def and_also(&block)
    self && yield(self)
  end
  
  # Convenience methods for a more idiomatic code than [ "users", "purchases" ].include?(controller_name) so that
  # the same can now be written as controller_name.is_included_in?('users', 'purchases')
  def is_included_in?(*others)
    others.flatten_splat.include?(self)
  end
  
  def is_excluded_from?(*others)
    others.flatten_splat.exclude?(self)
  end

  # Similar to is_a? or kind_of? but with an array of possible classes. Returns the matching class or a nil.
  def is_one_kind_of?(*klasses)
    klasses.flatten_splat.detect {|klass| klass === self }
  end
end
