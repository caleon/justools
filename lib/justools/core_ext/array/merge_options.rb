unless Hash.method_defined?(:extractable_options?)
  class Hash
    # Duplicated from ActiveSupport
    def extractable_options?
      instance_of?(Hash)
    end
  end
end

class Array
  def extract_options_without_merge
    options_extractable? ? last : {}
  end
  
  def extract_options_without_merge!
    options_extractable? ? pop  : {}
  end
  
  def options_extractable?
    last.is_a?(Hash) && last.extractable_options?
  end
  
  def extract_options_with_merge(update_hash = {})
    extract_options_without_merge.merge(update_hash  || {})
  end
  alias_method :extract_options, :extract_options_with_merge
  
  def extract_options_with_merge!(update_hash = {})
    extract_options_without_merge!.merge(update_hash || {})
  end
  alias_method :extract_options!, :extract_options_with_merge!
  
  ##
  # == Merging options
  def merge_options(update_hash = {})
    endex, base_hash = options_extractable? ? [-2, last] : [-1, {}]
    self[0..endex] + Array[base_hash.merge(update_hash || {})]
  end
  alias_method :merge_opts, :merge_options

  def merge_options!(update_hash = {})
    push(extract_options!(update_hash))
  end
  alias_method :merge_opts!, :merge_options!
end
