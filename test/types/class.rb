require "types"

describe Types::Class do
	let(:signature) {"Class"}
	let(:type) {Types.parse(signature)}
	
	it "can parse type signature" do
		expect(type).to be == subject
	end
	
	it "can generate type signature" do
		expect(type.to_s).to be == signature
	end
	
	it "is a composite type" do
		expect(type).not.to be(:composite?)
	end
	
	it "can parse strings" do
		expect(type.parse("Object")).to be == Object
	end
	
	with "specific base class" do
		let(:signature) {"Class(::Numeric)"}
		
		it "can parse strings" do
			expect(type.parse("Integer")).to be == Integer
		end
		
		it "can fail parse non-matching class" do
			expect{type.parse("String")}.to raise_exception(ArgumentError)
		end
	end
end
