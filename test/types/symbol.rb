require "types"

describe Types::Symbol do
	let(:signature) {"Symbol"}
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
		expect(type.parse("type")).to be == :type
	end
	
	it "can parse symbols" do
		expect(type.parse(:type)).to be == :type
	end
end
