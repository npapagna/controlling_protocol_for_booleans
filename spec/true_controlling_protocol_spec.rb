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

    it 'should not evaluate the :else block when provided' do
      true.if_true lambda{}, :else => lambda { fail }
    end

  end

  describe 'when responding to the :if_false message' do

    describe 'when the :else block is not provided' do

      it 'should return itself' do
        result = true.if_false lambda {}

        result.should == true
      end

      it 'should not evaluate the block received as collaborator' do
        true.if_false lambda { fail }
      end

    end

    describe 'when the :else block is provided' do

      it 'should return the value of the :else block' do
        result = true.if_false lambda {}, :else => lambda { 7 }

        result.should == 7
      end

    end

  end

  describe 'when responding to the :if message' do

    it "should return the value of the :true block" do
      result = true.if :true => lambda{ 7 }

      result.should == 7
    end

    it "should not evaluate the :else block when provided" do
      true.if :true => lambda{}, :else => lambda{ fail }
    end

    it "should not evaluate the :false block when provided" do
      true.if :true => lambda{}, :false => lambda{ fail }
    end

    it "should fail when no collaborators are provided" do
      lambda{ true.if }.should raise_error(Exception, ":true block was not provided")
    end

    it "should fail when :true block is not provided" do
      lambda{ true.if {} }.should raise_error(Exception, ":true block was not provided")
    end

  end

  describe 'when responding to the :and message' do

    it 'should return the value of the block received as collaborator' do
      result = true.and { false }

      result.should == false
    end

    end

  describe 'when responding to the :or message' do

    it 'should return the itself' do
      result = true.or { false }

      result.should == true
    end

    it 'should not evaluate the block received as collaborator' do
      true.or { fail }
    end

  end

end
