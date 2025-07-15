# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative "generic"

module Types
	# Represents a symbol type.
	#
	# ```ruby
	# type = Types::Symbol
	# type.parse("foo") # => :foo
	# ```
	module Symbol
		extend Generic
		
		# Parses the input as a symbol.
		# @parameter input [Object] The value to parse.
		# @returns [Symbol] The parsed symbol value.
		def self.parse(input)
			input.to_sym
		end
		
		# @returns [String] the RBS type string, e.g. `Symbol`.
		def self.to_rbs
			"Symbol"
		end
	end
end
