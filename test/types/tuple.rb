# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require "types"

describe Types::Tuple do
	let(:signature) {"Tuple(String, Integer)"}
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
		expect(type.parse('"Hello,World", "42"')).to be == ["Hello,World", 42]
	end
	
	with "#to_rbs" do
		it "emits RBS type" do
			expect(type.to_rbs).to be == "[String, Integer]"
		end
	end
end
