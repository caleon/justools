class Array
  # Compares two arrays to see if the elements are same but simply rearranged.
  def rearranges?(*other_ary)
    Set.new(self) == Set.new(other_ary.flatten_splat)
  end
  
  def subset?(other_ary)
    other_ary.is_a?(Array) or raise ArgumentError, "Other array in argument must be an Array"
    Set.new(self).subset?(Set.new(other_ary))
  end
  
  def is_included_in?(other_ary)
    other_ary.is_a?(Array) or raise ArgumentError, "Other array in argument must be an Array"
    super || subset?(other_ary)
  end
  
  # Careful with this. This means 4 out of 5 elements can be the same but if not all of this self Array object are a part of other_ary,
  # this returns true, as in "Yes, depite having 4 out of 5 in other_ary, I am excluded from the other_ary."
  def is_excluded_from?(other_ary)
    other_ary.is_a?(Array) or raise ArgumentError, "Other array in argument must be an Array"
    super || not_subset?(other_ary)
  end

  alias_method :include_one?, :include?
  def include_all?(*other_ary)
    other_ary.flatten_splat!
    include_one(other_ary) || superset?(other_ary)
  end #alias_method :include?,     :include_all?
end