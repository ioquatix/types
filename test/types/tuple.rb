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
end
