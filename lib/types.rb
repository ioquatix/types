# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require_relative "types/version"

require_relative "types/any"
require_relative "types/array"
require_relative "types/block"
require_relative "types/boolean"
require_relative "types/class"
require_relative "types/decimal"
require_relative "types/float"
require_relative "types/hash"
require_relative "types/integer"
require_relative "types/interface"
require_relative "types/lambda"
require_relative "types/method"
require_relative "types/nil"
require_relative "types/numeric"
require_relative "types/string"
require_relative "types/symbol"
require_relative "types/tuple"

# @namespace
module Types
	# The main module for the types library.
	#
	# Provides parsing and construction of type signatures.
	#
	# ```ruby
	# Types.parse("Array(String)") # => Types::Array(Types::String)
	# ```
	VALID_SIGNATURE = /\A[a-zA-Z\(\):,_|\s]+\z/

	# Parses a type signature string and returns the corresponding type instance.
	# @parameter signature [String] The type signature to parse.
	# @returns [Object] The type instance.
	# @raises [ArgumentError] if the signature is invalid.
	def self.parse(signature)
		if signature =~ VALID_SIGNATURE
			eval(signature, binding)
		else
			raise ArgumentError, "Invalid type signature: #{signature.inspect}!"
		end
	end
end
