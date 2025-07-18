# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2024-2025, by Samuel Williams.

require "types"
require "rbs"

describe Types::Interface do
	let(:signature) {"Interface(MyInterface)"}
	let(:type) {Types.parse(signature)}
	
	it "can parse type signature" do
		expect(type).to be(:kind_of?, subject)
		expect(type.name).to be == "MyInterface"
	end
	
	it "can generate type signature" do
		expect(type.to_s).to be == signature
	end
	
	it "is a composite type" do
		expect(type).to be(:composite?)
	end
	
	with "#to_rbs" do
		it "emits RBS interface type with underscore prefix" do
			expect(type.to_rbs).to be == "_MyInterface"
		end
		
		it "parses emitted RBS type with RBS::Parser.parse_type" do
			parsed = RBS::Parser.parse_type(type.to_rbs)
			expect(parsed).to be_a(RBS::Types::Interface)
		end
	end
	
	with "nested interface" do
		let(:signature) {"Interface(MyLibrary::MyInterface)"}
		let(:type) {Types.parse(signature)}
		
		it "can parse nested interface signature" do
			expect(type).to be(:kind_of?, subject)
			expect(type.name).to be == "MyLibrary::MyInterface"
		end
		
		it "emits RBS interface type with underscore on last component" do
			expect(type.to_rbs).to be == "MyLibrary::_MyInterface"
		end
		
		it "parses emitted RBS type with RBS::Parser.parse_type" do
			parsed = RBS::Parser.parse_type(type.to_rbs)
			expect(parsed).to be_a(RBS::Types::Interface)
		end
	end
	
	with "|" do
		let(:other) {Types::String}
		
		it "can create union type" do
			union = type | other
			
			expect(union).to be(:kind_of?, Types::Any)
			expect(union.to_s).to be == "Interface(MyInterface) | String"
		end
	end
end
