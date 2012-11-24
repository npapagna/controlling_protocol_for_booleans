  module FalseControllingProtocol

  def if_true a_block, options = { :else => lambda{ self } }
    options[:else].call
  end

  def if_false a_block, options = {}
    a_block.call
  end

  def if options = { :false => lambda{ raise ':false block was not provided' } }
    options[:false].call
  end

  def and &a_block
    self
  end

  def or &a_block
    a_block.call
  end

end