require "rspec"
require "../lib/true_controlling_protocol"

describe TrueControllingProtocol do

  before(:all) do
    TrueClass.send :include, TrueControllingProtocol
  end

  describe 'when responding to the :if_true message' do

    it 'should return the value of the block received as collaborator' do
      result = true.if_true lambda { 7 }

      result.should == 7
    end

    it 'should evaluate the block received as collaborator' do
      a_block = double("Proc")
      a_block.should_receive :call

      true.if_true a_block
    end

    it 'should not evaluate the :else block when provided' do
      a_block = double("Proc")
      a_block.should_not_receive :call

      true.if_true lambda{}, a_block
    end

  end

  describe 'when responding to the :if_false message' do

    describe 'when the :else block is not provided' do

      it 'should return itself' do
        result = true.if_false lambda {}

        result.should == true
      end

      it 'should not evaluate the block received as collaborator' do
        a_block = double("Proc")
        a_block.should_not_receive :call

        true.if_false a_block
      end

    end

    describe 'when the :else block is provided' do

      it 'should return the value of the :else block' do
        result = true.if_false lambda {}, :else => lambda { 7 }

        result.should == 7
      end

      it 'should evaluate the :else block' do
        a_block = double("Proc")
        a_block.should_receive :call

        true.if_false lambda {}, :else => a_block
      end

    end

  end

  describe 'when responding to the :if message' do

    it "should evaluate the :true block" do
      a_block = double("Proc")
      a_block.should_receive :call

      true.if :true => a_block
    end

    it "should return the value of the :true block" do
      result = true.if :true => lambda{ 7 }

      result.should == 7
    end

    it "should not evaluate the :else block when provided" do
      a_block = double("Proc")
      a_block.should_not_receive :call

      true.if :true => lambda{}, :else => a_block
    end

    it "should not evaluate the :false block when provided" do
      a_block = double("Proc")
      a_block.should_not_receive :call

      true.if :true => lambda{}, :false => a_block
    end

    it "should fail when no collaborators are provided" do
      lambda{ true.if }.should raise_error(Exception, ":true block was not provided")
    end

    it "should fail when :true block is not provided" do
      lambda{ true.if {} }.should raise_error(Exception, ":true block was not provided")
    end

  end

  describe 'when responding to the :and message' do

    it 'should return the value of the block received as' do
      result = true.and { false }

      result.should == false
    end

    end

  describe 'when responding to the :or message' do

    it 'should return the itself' do
      result = true.or { false }

      result.should == true
    end

  end

end
