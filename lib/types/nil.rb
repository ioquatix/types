# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require_relative "generic"

module Types
	# Represents the nil type.
	#
	# ```ruby
	# type = Types::Nil
	# type.parse("nil") # => nil
	# ```
	module Nil
		extend Generic
		
		# Parses the input as nil if it matches.
		# @parameter input [Object] The value to parse.
		# @returns [NilClass] nil if the input matches.
		# @raises [ArgumentError] if the input cannot be converted to nil.
		def self.parse(input)
			if input =~ /nil|null/i
				return nil
			else
				raise ArgumentError, "Cannot coerce #{input.inspect} into Nil!"
			end
		end
		
		# @returns [String] the RBS type string, e.g. `nil`.
		def self.to_rbs
			"nil"
		end
	end
end
