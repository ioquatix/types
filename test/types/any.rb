# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require "types"

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
	
	with "#to_rbs" do
		it "emits RBS type" do
			expect(type.to_rbs).to be == "Integer | String"
		end
		
		it "emits nested RBS type" do
			nested = Types::Any.new([Types::Array(Types::String), Types::Hash(Types::String, Types::Integer)])
			expect(nested.to_rbs).to be == "Array[String] | { String => Integer }"
		end
	end
end
