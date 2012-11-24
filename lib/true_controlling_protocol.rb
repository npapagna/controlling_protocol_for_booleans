module TrueControllingProtocol

  def if_true a_block, options = {}
    a_block.call
  end

  def if_false a_block, options = { :else => lambda{ self } }
    options[:else].call
  end

  def if options = { :true => lambda{ raise ':true block was not provided' } }
    options[:true].call
  end

  def and &a_block
    a_block.call
  end

  def or &a_block
    self
  end

end