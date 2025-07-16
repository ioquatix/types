# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require "types"

describe Types::Array do
	let(:signature) {"Array(String)"}
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
	
	it "can parse strings" do
		expect(type.parse('"Hello,World", "42"')).to be == ["Hello,World", "42"]
	end
	
	with "#to_rbs" do
		it "emits RBS type" do
			expect(type.to_rbs).to be == "Array[String]"
		end
		
		it "emits nested RBS type" do
			nested = Types::Array(Types::Hash(Types::String, Types::Integer))
			expect(nested.to_rbs).to be == "Array[{ String => Integer }]"
		end
	end
	
	with "#resolve" do
		it "resolves to Ruby Array class" do
			expect(type.resolve).to be == ::Array
		end
		
		it "resolves through parsing" do
			expect(Types.parse("Array(String)").resolve).to be == ::Array
		end
		
		it "resolves with unknown types" do
			array_unknown = Types.parse("Array(UnknownType)")
			expect(array_unknown.resolve).to be == ::Array
		end
	end
end
