require "types"

describe Types::Integer do
	let(:signature) {"Integer"}
	let(:type) {Types.parse(signature)}
	
	it "can parse type signature" do
		expect(type).to be == subject
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
	
	it "can parse negative integers" do
		expect(type.parse(-42)).to be == -42
	end
end
