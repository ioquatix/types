# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require "types"
require "rbs"

describe Types::Any do
	let(:signature) {"Integer | String"}
	let(:type) {Types.parse(signature)}
	
	it "can parse type signature" do
		expect(type).to be(:kind_of?, subject)
	end
	
	it "can generate type signature" do
		expect(type.to_s).to be == signature
	end
	
	it "is a composite type" do
		expect(type).not.to be(:composite?)
	end
	
	it "can parse strings" do
		expect(type.parse("Hello World")).to be == "Hello World"
	end
	
	it "can parse integers" do
		expect(type.parse("42")).to be == 42
	end
	
	it "accepts anything when empty (like RBS untyped)" do
		empty_any = Types::Any.new([])
		expect(empty_any.parse("hello")).to be == "hello"
		expect(empty_any.parse(42)).to be == 42
		expect(empty_any.parse(nil)).to be == nil
		expect(empty_any.parse([])).to be == []
	end
	
	with "#to_rbs" do
		it "emits RBS type" do
			expect(type.to_rbs).to be == "Integer | String"
		end
		
		it "parses emitted RBS type with RBS::Parser.parse_type" do
			expect(RBS::Parser.parse_type(type.to_rbs)).to be_a(RBS::Types::Union)
			nested = Types::Any.new([Types::Array(Types::String), Types::Hash(Types::String, Types::Integer)])
			expect(RBS::Parser.parse_type(nested.to_rbs)).to be_a(RBS::Types::Union)
			empty_any = Types::Any.new([])
			expect(RBS::Parser.parse_type(empty_any.to_rbs)).to be_a(RBS::Types::Bases::Any)
		end
		
		it "emits nested RBS type" do
			nested = Types::Any.new([Types::Array(Types::String), Types::Hash(Types::String, Types::Integer)])
			expect(nested.to_rbs).to be == "Array[String] | Hash[String, Integer]"
		end
		
		it "emits 'untyped' for empty Any" do
			empty_any = Types::Any.new([])
			expect(empty_any.to_rbs).to be == "untyped"
		end
	end
	
	with "#resolve" do
		it "does not have resolve method since union types don't map to single Ruby types" do
			expect(type).not.to be(:respond_to?, :resolve)
		end
	end
end
