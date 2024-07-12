# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative 'generic'

require 'bigdecimal'

module Types
	module Decimal
		extend Generic
		
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
