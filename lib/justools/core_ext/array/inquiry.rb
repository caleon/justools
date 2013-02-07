require 'set'
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
  
  def subset?(other_ary)
    Set.new(self).subset?(Set.new(other_ary))
  end
  
  def in?(other_ary)
    super || subset?(other_ary)
  end
end
