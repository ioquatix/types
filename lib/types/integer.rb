# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative "generic"

module Types
	# Represents an integer type.
	#
	# ```ruby
	# type = Types::Integer
	# type.parse("42") # => 42
	# ```
	module Integer
		extend Generic
		
		# Parses the input as an integer.
		# @parameter input [Object] The value to parse.
		# @returns [Integer] The parsed integer value.
		# @raises [ArgumentError] if the input cannot be converted to an integer.
		def self.parse(input)
			Integer(input)
		end
		
		# @returns [String] the RBS type string, e.g. `Integer`.
		def self.to_rbs
			"Integer"
		end
	end
end
