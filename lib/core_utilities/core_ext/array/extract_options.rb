class Array
  def extract_options
    options_extractable? ? last : {}
  end
  
  def extract_options!
    options_extractable? ? pop  : {}
  end
  
  def options_extractable?
    last.is_a?(Hash) && last.extractable_options?
  end
  
  def extract_options_with_merge(update_hash={})
    extract_options_without_merge.merge(update_hash  || {})
  end
  alias_method_chain :extract_options,  :merge
  
  def extract_options_with_merge!(update_hash={})
    extract_options_without_merge!.merge(update_hash || {})
  end
  alias_method_chain :extract_options!, :merge
end