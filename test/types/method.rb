# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require "types"

describe Types::Method do
	let(:signature) {"Method(Object, returns: String)"}
	let(:type) {Types.parse(signature)}
	
	it "can parse type signature" do
		expect(type).to be(:kind_of?, subject)
		
		expect(type.receiver_type).to be == ::Object
		expect(type.argument_types).to be == []
		expect(type.return_type).to be == Types::String
	end
	
	it "can generate type signature" do
		expect(type.to_s).to be == signature
	end
	
	it "is a composite type" do
		expect(type).to be(:composite?)
	end
	
	it "can parse strings" do
		expect(type.parse("to_s")).to be(:kind_of?, UnboundMethod)
	end
	
	with "#to_rbs" do
		it "emits RBS type" do
			expect(type.to_rbs).to be == "Method[Object, () -> String]"
		end
	end
end
