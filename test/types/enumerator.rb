# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require "types"
require "rbs"

describe Types::Enumerator do
	let(:signature) {"Enumerator(String)"}
	let(:type) {Types.parse(signature)}
	
	it "can parse type signature" do
		expect(type).to be(:kind_of?, subject)
	end
	
	it "can generate type signature" do
		expect(type.to_s).to be == signature
	end
	
	it "is a composite type" do
		expect(type).to be(:composite?)
	end
	
	it "can parse enumerator from array" do
		result = type.parse(["Hello", "World"])
		expect(result).to be_a(::Enumerator)
		expect(result.to_a).to be == ["Hello", "World"]
	end
	
	it "can parse existing enumerator" do
		enumerator = ["Hello", "World"].each
		result = type.parse(enumerator)
		expect(result).to be_a(::Enumerator)
		expect(result.to_a).to be == ["Hello", "World"]
	end
	
	with "#to_rbs" do
		it "emits RBS type" do
			expect(type.to_rbs).to be == "Enumerator[String]"
		end
		
		it "parses emitted RBS type with RBS::Parser.parse_type" do
			parsed = RBS::Parser.parse_type(type.to_rbs)
			expect(parsed).to be_a(RBS::Types::ClassInstance)
		end
		
		it "emits nested RBS type" do
			nested = Types::Enumerator.new(Types::Hash.new(Types::String, Types::Integer))
			expect(nested.to_rbs).to be == "Enumerator[Hash[String, Integer]]"
		end
		
		it "parses emitted nested RBS type with RBS::Parser.parse_type" do
			nested = Types::Enumerator.new(Types::Hash.new(Types::String, Types::Integer))
			parsed = RBS::Parser.parse_type(nested.to_rbs)
			expect(parsed).to be_a(RBS::Types::ClassInstance)
		end
	end
	
	with "#resolve" do
		it "resolves to Ruby Enumerator class" do
			expect(type.resolve).to be == ::Enumerator
		end
		
		it "resolves through parsing" do
			expect(Types.parse("Enumerator(String)").resolve).to be == ::Enumerator
		end
		
		it "handles unknown item types" do
			enum_unknown = Types.parse("Enumerator(UnknownType)")
			expect(enum_unknown.resolve).to be == ::Enumerator
		end
	end
end 