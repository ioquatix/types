# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

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
				Kernel.BigDecimal(input, ::Float::DIG+1)
			else
				Kernel.BigDecimal(input)
			end
		end
		
		# Resolves to the actual Ruby BigDecimal class.
		# @returns [Class] The BigDecimal class.
		def self.resolve
			::BigDecimal
		end
	end
	
	# Alias for the Decimal type.
	BigDecimal = Decimal
end
