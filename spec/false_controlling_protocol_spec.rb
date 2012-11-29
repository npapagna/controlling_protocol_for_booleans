require 'spec_helper'

describe FalseControllingProtocol do

  before(:all) do
    FalseClass.send :include, FalseControllingProtocol
  end

  describe 'when responding to the :if_true message' do

    describe 'when the :else block is not provided' do

      it 'should return itself' do
        result = false.if_true lambda {}

        result.should == false
      end

      it 'should not evaluate the block received as collaborator' do
        false.if_true lambda{ fail }
      end

    end

    describe 'when the :else block is provided' do

      it 'should return the value of the :else block' do
        result = false.if_true lambda {}, :else => lambda { 7 }

        result.should == 7
      end

    end
  end

  describe 'when responding to the :if_false message' do

    it 'should return the value of the block received as collaborator' do
      result = false.if_false lambda { 7 }

      result.should == 7
    end

    it 'should not evaluate the :else block when provided' do
      false.if_false lambda{}, :else => lambda{ fail }
    end

  end

  describe 'when responding to the :if message' do

    it "should return the value of the :false block" do
      result = false.if :false => lambda{ 7 }

      result.should == 7
    end

    it "should not evaluate the :else block when provided" do
      false.if :false => lambda{}, :else => lambda{ fail }
    end

    it "should not evaluate the :true block when provided" do
      false.if :false => lambda{}, :true => lambda{ fail }
    end

    it "should fail when no collaborators are provided" do
      lambda{ false.if }.should raise_error(Exception, ":false block was not provided")
    end

    it "should fail when :true block is not provided" do
      lambda{ false.if {} }.should raise_error(Exception, ":false block was not provided")
    end

  end

  describe 'when responding to the :and message' do

    it 'should return itself' do
      result = false.and { true }

      result.should == false
    end

    it 'should not evaluate the block received as collaborator' do
      false.and { fail }
    end

  end

  describe 'when responding to the :or message' do

    it 'should return the value of the block received as collaborator' do
      result = false.or { true }

      result.should == true
    end

  end

end