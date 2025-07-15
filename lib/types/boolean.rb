# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require_relative "generic"

module Types
	# Represents a boolean type.
	#
	# ```ruby
	# type = Types::Boolean
	# type.parse("true") # => true
	# type.parse("no")   # => false
	# ```
	module Boolean
		extend Generic
		
		# Parses the input as a boolean.
		# @parameter input [Object] The value to parse.
		# @returns [Boolean] The parsed boolean value.
		# @raises [ArgumentError] if the input cannot be converted to a boolean.
		def self.parse(input)
			if input =~ /t(rue)?|y(es)?/i
				return true
			elsif input =~ /f(alse)?|n(o)?/i
				return false
			else
				raise ArgumentError, "Cannot coerce #{input.inspect} into Boolean!"
			end
		end

		# @returns [String] the RBS type string, e.g. `bool`.
		def self.to_rbs
			"bool"
		end
	end
end
