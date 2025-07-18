# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require "types"
require "rbs"

describe Types::Numeric do
	let(:signature) {"Numeric"}
	let(:type) {Types.parse(signature)}
	
	it "can parse type signature" do
		expect(type).to be_a(Types::Named)
		expect(type.name).to be == "Numeric"
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
	
	with "#to_rbs" do
		it "emits RBS type" do
			expect(type.to_rbs).to be == "Numeric"
		end
	end
	
	with ".resolve" do
		it "resolves to Ruby Numeric class" do
			expect(type.resolve).to be == ::Numeric
		end
	end
end
