# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2025, by Samuel Williams.

require "types"
require "rbs"

describe Types::Named do
	it "should handle unknown types via const_missing" do
		type = Types.parse("UnknownType1")
		expect(type).to be_a(Types::Named)
		expect(type.name).to be == "UnknownType1"
		expect(type.to_s).to be == "UnknownType1"
		expect(type.to_rbs).to be == "UnknownType1"
	end
	
	it "should handle union types with unknown types" do
		type = Types.parse("UnknownType1 | String")
		expect(type).to be_a(Types::Any)
		expect(type.to_s).to be == "UnknownType1 | String"
	end
	
	it "should handle composite types with unknown types" do
		type = Types.parse("Array(UnknownType)")
		expect(type).to be_a(Types::Array)
		expect(type.to_s).to be == "Array(UnknownType)"
	end
	
	it "is unable to parse values of unknown types" do
		type = Types.parse("UnknownType1")
		expect{type.parse("foo")}.to raise_exception(ArgumentError, message: be =~ /Unknown type:/)
	end
	
	it "should work with the | operator" do
		named = Types::Named.new("CustomType")
		union = named | Types::String
		expect(union).to be_a(Types::Any)
		expect(union.to_s).to be == "CustomType | String"
	end
	
	it "should be equal to other Named types with same name" do
		named1 = Types::Named.new("CustomType")
		named2 = Types::Named.new("CustomType")
		named3 = Types::Named.new("OtherType")
		
		expect(named1).to be == named2
		expect(named1).not.to be == named3
	end
	
	it "should not be composite" do
		named = Types::Named.new("CustomType")
		expect(named.composite?).to be == false
	end
	
	it "should resolve to actual Ruby types when they exist" do
		named = Types::Named.new("String")
		expect(named.resolve).to be == ::String
		
		named = Types::Named.new("Array")
		expect(named.resolve).to be == ::Array
		
		named = Types::Named.new("Hash")
		expect(named.resolve).to be == ::Hash
	end
	
	it "should resolve to nil for unknown types" do
		named = Types::Named.new("UnknownType1")
		expect(named.resolve).to be == nil
		
		named = Types::Named.new("NonExistentClass")
		expect(named.resolve).to be == nil
	end
	
	it "should resolve correctly when used in parsing" do
		# Test parsing unknown types creates Named that resolves to nil
		parsed_unknown = Types.parse("UnknownType1")
		expect(parsed_unknown).to be_a(Types::Named)
		expect(parsed_unknown.resolve).to be == nil
		
		# Test parsing known Ruby types through Named
		parsed_known = Types::Named.new("File")
		expect(parsed_known.resolve).to be == ::File
	end
	
	it "should resolve correctly with namespaced types" do
		# Test with a namespaced Ruby constant
		named = Types::Named.new("File::Stat")
		expect(named.resolve).to be == ::File::Stat
		
		# Test with non-existent namespace
		named = Types::Named.new("NonExistent::Class")
		expect(named.resolve).to be == nil
		
		# Test with deeply nested namespace
		named = Types::Named.new("NonExistent::Namespace::Class")
		expect(named.resolve).to be == nil
	end
	
	it "should resolve through parsing for unknown types" do
		# Unknown types through parsing (creates Named via const_missing)
		expect(Types.parse("UnknownType1").resolve).to be == nil
		expect(Types.parse("MyCustomClass").resolve).to be == nil
	end
	
	it "should allow to_rbs calls on parsed types with real classes" do
		# Test the specific scenario mentioned by the user
		type = Types.parse("Hash(String, File)")
		expect(type.to_rbs).to be == "Hash[String, File]"
		
		# Confirm it parses as RBS
		parsed = RBS::Parser.parse_type(type.to_rbs)
		expect(parsed).to be_a(RBS::Types::ClassInstance)
	end
	
	it "should allow to_rbs calls on various composite types with real classes" do
		# Test Array with File
		array_type = Types.parse("Array(File)")
		expect(array_type.to_rbs).to be == "Array[File]"
		
		parsed_array = RBS::Parser.parse_type(array_type.to_rbs)
		expect(parsed_array).to be_a(RBS::Types::ClassInstance)
		
		# Test Enumerator with File
		enumerator_type = Types.parse("Enumerator(File)")
		expect(enumerator_type.to_rbs).to be == "Enumerator[File]"
		
		parsed_enumerator = RBS::Parser.parse_type(enumerator_type.to_rbs)
		expect(parsed_enumerator).to be_a(RBS::Types::ClassInstance)
		
		# Test Hash with different real classes
		hash_type = Types.parse("Hash(String, Integer)")
		expect(hash_type.to_rbs).to be == "Hash[String, Integer]"
		
		parsed_hash = RBS::Parser.parse_type(hash_type.to_rbs)
		expect(parsed_hash).to be_a(RBS::Types::ClassInstance)
		
		# Test Tuple with real classes
		tuple_type = Types.parse("Tuple(String, File, Integer)")
		expect(tuple_type.to_rbs).to be == "[String, File, Integer]"
		
		parsed_tuple = RBS::Parser.parse_type(tuple_type.to_rbs)
		expect(parsed_tuple).to be_a(RBS::Types::Tuple)
	end
	
	it "should work with to_rbs on real class instances directly" do
		# Test that real classes have the to_rbs method aliased to to_s
		expect(File.to_rbs).to be == "File"
		expect(String.to_rbs).to be == "String"
		expect(Integer.to_rbs).to be == "Integer"
		expect(Array.to_rbs).to be == "Array"
		expect(Hash.to_rbs).to be == "Hash"
	end
end
