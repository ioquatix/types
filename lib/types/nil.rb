# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative 'generic'

module Types
	module Nil
		extend Generic
		
		def self.parse(input)
			if input =~ /nil|null/i
				return nil
			else
				raise ArgumentError, "Cannot coerce #{input.inspect} into Nil!"
			end
		end
	end
end
