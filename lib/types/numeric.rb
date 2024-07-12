# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative 'generic'

module Types
	module Numeric
		extend Generic
		
		def self.parse(input)
			case input
			when Numeric then input
			when /\./ then Float(input)
			else Integer(input)
			end
		end
	end
end
