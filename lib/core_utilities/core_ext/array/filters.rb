class Array
  #############################
  ## Quick selectors/filters ##
  #############################
  def select_kind_of(klass);   select { |el| el.kind_of?(klass) }; end
  def reject_kind_of(klass);   reject { |el| el.kind_of?(klass) }; end
  def select_kind_of!(klass); select! { |el| el.kind_of?(klass) }; end
  def reject_kind_of!(klass); reject! { |el| el.kind_of?(klass) }; end
end