# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative 'generic'

module Types
	# A lambda that represents a function (or callable object).
	class Lambda
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
				"Lambda(#{@argument_types.join(', ')}, returns: #{@return_type})"
			else
				"Lambda(#{@argument_types.join(', ')})"
			end
		end
		
		def parse(input)
			case input
			when ::String
				eval("lambda{#{input}}", TOPLEVEL_BINDING)
			when ::Proc
				input
			else
				raise ArgumentError, "Cannot coerce #{input.inpsect} into Lambda!"
			end
		end
	end
	
	def self.Lambda(*argument_types, returns: nil)
		Lambda.new(argument_types, returns)
	end
end
