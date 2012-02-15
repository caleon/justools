class Array
  # flatten_splat! is used for dealing conveniently with the common pattern
  # where a method's arguments has a splat (*) operator, but the developer wants
  # to provide the option of the method accepting either a list or an array for
  # the argument.
  #
  # === Examples
  #
  #   Before:                                 Now:
  #   def do_something(*args)                 def do_something(*args)
  #     if args.one? && args[0].is_a?(Array)    args.flatten_splat!
  #       args = args.shift                   end
  #     end
  #   end
  def flatten_splat!
    flatten_splat(true)
  end

  def flatten_splat(with_bang=false)
    flatten_splat_needed? ? with_bang ? flatten! : flatten : self
  end

  def flatten_splat_needed?
    self.size == 1 and first.is_a?(Array)
  end
  private :flatten_splat_needed?
end
