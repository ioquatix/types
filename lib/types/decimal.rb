# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative "generic"
require "bigdecimal"

module Types
	# Represents a decimal type using BigDecimal.
	#
	# ```ruby
	# type = Types::Decimal
	# type.parse("3.14") # => #<BigDecimal ...>
	# ```
	module Decimal
		extend Generic
		
		# Parses the input as a BigDecimal.
		# @parameter input [Object] The value to parse.
		# @returns [BigDecimal] The parsed decimal value.
		# @raises [ArgumentError] if the input cannot be converted to a BigDecimal.
		def self.parse(input)
			case input
			when ::Float
				BigDecimal(input, ::Float::DIG+1)
			else
				BigDecimal(input)
			end
		end
	end
end
