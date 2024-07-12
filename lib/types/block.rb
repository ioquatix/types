# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative 'method'

module Types
	class Block
		include Generic
		
		def initialize(argument_types, return_type)
			@argument_types = argument_types
			@return_type = return_type
		end
		
		attr :argument_types
		attr :return_type
		
		def composite?
			true
		end
		
		def to_s
			if @return_type
				"Block(#{@argument_types.join(', ')}, returns: #{@return_type})"
			else
				"Block(#{@argument_types.join(', ')})"
			end
		end
	end
	
	def self.Block(*argument_types, returns: nil)
		Block.new(argument_types, returns)
	end
end
