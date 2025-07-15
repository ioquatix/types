# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative "generic"

module Types
	# Represents a numeric type (integer or float).
	#
	# ```ruby
	# type = Types::Numeric
	# type.parse("42")   # => 42
	# type.parse("3.14") # => 3.14
	# ```
	module Numeric
		extend Generic
		
		# Parses the input as a numeric value (integer or float).
		# @parameter input [Object] The value to parse.
		# @returns [Numeric] The parsed numeric value.
		def self.parse(input)
			case input
			when Numeric then input
			when /\./ then Float(input)
			else Integer(input)
			end
		end
	end
end
