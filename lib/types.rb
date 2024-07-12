# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative 'types/version'

require_relative 'types/any'
require_relative 'types/array'
require_relative 'types/block'
require_relative 'types/boolean'
require_relative 'types/class'
require_relative 'types/decimal'
require_relative 'types/float'
require_relative 'types/hash'
require_relative 'types/integer'
require_relative 'types/lambda'
require_relative 'types/method'
require_relative 'types/nil'
require_relative 'types/numeric'
require_relative 'types/string'
require_relative 'types/symbol'
require_relative 'types/tuple'

module Types
	VALID_SIGNATURE = /\A[a-zA-Z\(\):, |]+\z/
	
	def self.parse(signature)
		if signature =~ VALID_SIGNATURE
			eval(signature, binding)
		else
			raise ArgumentError, "Invalid type signature: #{signature.inspect}!"
		end
	end
end
