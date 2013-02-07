require 'set'

class Set
  def not_subset?(set)
    set.is_a?(Set) or raise ArgumentError, "value must be a set"
    return true if set.size > size
    any? { |o| set.exclude?(o) }
  end
end
