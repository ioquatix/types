# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require "types"

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
	
	it "should parse values through without modification" do
		type = Types.parse("UnknownType1")
		expect(type.parse("hello")).to be == "hello"
		expect(type.parse(42)).to be == 42
		expect(type.parse(nil)).to be == nil
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
end 