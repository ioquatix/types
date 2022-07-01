require "types"

describe Types::Lambda do
	let(:signature) {"Lambda(Integer, returns: String)"}
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
		value = type.parse("|x| x*2")
		expect(value).to be(:kind_of?, Proc)
		expect(value.call(2)).to be == 4
	end
end
