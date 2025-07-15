# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require_relative "generic"

module Types
	# Represents a string type.
	#
	# ```ruby
	# type = Types::String
	# type.parse(42) # => "42"
	# ```
	module String
		extend Generic
		
		# Parses the input as a string.
		# @parameter input [Object] The value to parse.
		# @returns [String] The parsed string value.
		def self.parse(input)
			input.to_s
		end
		
		# @returns [String] the RBS type string, e.g. `String`.
		def self.to_rbs
			"String"
		end
	end
end
