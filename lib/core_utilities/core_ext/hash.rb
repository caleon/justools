class Hash
  def append_value(key, val, delimiter=' ')
    self.dup[key] = [ self[key], val ].compact.join(delimiter)
  end
  
  def append_value!(key, val, delimiter=' ')
    self[key]     = [ self[key], val ].compact.join(delimiter)
  end  
end