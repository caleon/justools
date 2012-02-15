module Enumerable
  def map_select(value_for_skip = nil)
    self.inject([]) do |acc, item|
      (value = yield(item)) == value_for_skip ? acc : acc << value
    end
  end
  
  def map_detect(value_for_no_matching = nil)
    self.each { |el| if result = yield(el) then return result end }
    value_for_no_matching
  end
end
