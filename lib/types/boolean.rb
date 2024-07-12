# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative 'generic'

module Types
	module Boolean
		extend Generic
		
		def self.parse(input)
			if input =~ /t(rue)?|y(es)?/i
				return true
			elsif input =~ /f(alse)?|n(o)?/i
				return false
			else
				raise ArgumentError, "Cannot coerce #{input.inspect} into Boolean!"
			end
		end
	end
end
