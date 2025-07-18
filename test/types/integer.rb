# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require "types"
require "rbs"

describe Types::Integer do
	let(:signature) {"Integer"}
	let(:type) {Types.parse(signature)}
	
	it "can parse type signature" do
		expect(type).to be_a(Types::Named)
		expect(type.name).to be == "Integer"
		expect(type.to_type).to be == subject
	end
	
	it "can generate type signature" do
		expect(type.to_s).to be == signature
	end
	
	it "isn't a composite type" do
		expect(type).not.to be(:composite?)
	end
	
	it "can parse strings" do
		expect(type.parse("42")).to be == 42
	end
	
	it "can parse integers" do
		expect(type.parse(42)).to be == 42
	end
	
	with "#to_rbs" do
		it "emits RBS type" do
			expect(type.to_rbs).to be == "Integer"
		end
		
		it "parses emitted RBS type with RBS::Parser.parse_type" do
			parsed = RBS::Parser.parse_type(type.to_rbs)
			expect(parsed).to be_a(RBS::Types::ClassInstance)
		end
	end
	
	with ".resolve" do
		it "resolves to Ruby Integer class" do
			expect(type.resolve).to be == ::Integer
		end
		
		it "resolves through parsing" do
			expect(Types.parse("Integer").resolve).to be == ::Integer
		end
	end
end
