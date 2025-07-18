
# Parses type signatures, must be defined at the top level for the purpose of name resolution.
class Types::Parser < BasicObject
	# Handles absolute type paths by creating absolute Named types for unknown types.
	module TOP
		def self.const_missing(name)
			::Types::Named.new("::#{name}")
		end
	end
	
	# Handles missing constants by creating Named types for unknown types.
	# This allows parsing of type signatures with unknown types.
	# @parameter name [Symbol] The name of the missing constant.
	# @returns [Named] A Named type representing the unknown type.
	def self.const_missing(name)
		::Types::Named.new(name.to_s)
	end
	
	def parse(signature)
		# Validate the signature format:
		unless signature.match?(/\A[a-zA-Z0-9\(\):,_|\s]+\z/)
			::Kernel.raise ::ArgumentError, "Invalid type signature: #{signature.inspect}!"
		end
		
		# Replace leading :: with TOP:: to handle absolute type paths
		normalized_signature = signature.gsub(/(?<=\A|\W)::/, "TOP::")
		
		binding = ::Kernel.binding
		
		return ::Kernel.eval(normalized_signature, binding)
	end
end

module Types
	PARSER = Parser.new
	
	self.define_singleton_method(:parse) do |signature|
		PARSER.parse(signature)
	end
	
	remove_const :Parser
end