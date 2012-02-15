require 'set'
require 'justools/core_ext/object'
require 'justools/core_ext/set'
require 'justools/core_ext/array/flatten_splat'

class Array
  # Compares two arrays to see if the elements are same but simply rearranged.
  #
  # === Parameters
  #
  # * +other_ary+ - An Array or a list of its elements.
  def rearranged?(*other_ary)
    Set.new(self) == Set.new(other_ary.flatten_splat)
  end
  alias_method :rearranges?, :rearranged?
  
  def subset_of?(other_ary)
    Set.new(self).subset?(Set.new(other_ary))
  end
  alias_method :subset?, :subset_of?
  
  def is_included_in?(other_ary)
    super || subset?(other_ary)
  end
  alias_method :in?, :is_included_in?
  
  # Careful with this. This means 4 out of 5 elements can be the same but if not
  # all of this self Array object are a part of other_ary, this returns true, as
  # in "Yes, depite having 4 out of 5 in other_ary, I am excluded from the
  # other_ary."
  def out_of?(other_ary)
    super || not_subset?(other_ary)
  end
  alias_method :is_excluded_from?, :out_of?

  alias_method :include_one?, :include?
  def include_all?(*other_ary)
    other_ary.flatten_splat!
    include_one(other_ary) || superset?(other_ary)
  end
  # alias_method :include?, :include_all?
end
