# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative 'generic'

module Types
	module String
		extend Generic
		
		def self.parse(input)
			input.to_s
		end
	end
end
