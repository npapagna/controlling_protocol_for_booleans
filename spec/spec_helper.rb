require 'rspec'

root_folder = File.dirname File.dirname(__FILE__)
lib_folder = "#{root_folder}/lib"

require "#{lib_folder}/false_controlling_protocol.rb"
require "#{lib_folder}/true_controlling_protocol.rb"