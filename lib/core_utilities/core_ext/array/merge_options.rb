class Array
  def merge_options(update_hash={})
    endex, base_hash = options_extractable? ? [ -2, last ] : [ -1, {} ]
    Array[ *self[0..endex], base_hash.merge(update_hash || {}) ]
  end
  alias_method :merge_opts, :merge_options

  def merge_options!(update_hash={})
    push(extract_options!(update_hash))
  end
  alias_method :merge_opts!, :merge_options!
end