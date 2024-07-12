# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative 'generic'

module Types
	# A method type attached to a receiver type.
	class Method
		include Generic
		
		def initialize(receiver_type, argument_types, return_type)
			@receiver_type = receiver_type
			@argument_types = argument_types
			@return_type = return_type
		end
		
		attr :receiver_type
		attr :argument_types
		attr :return_type
		
		def composite?
			true
		end
		
		def to_s
			buffer = ::String.new
			
			if @argument_types&.any?
				buffer << "Method(#{@receiver_type}, #{@argument_types.join(', ')}"
			else
				buffer << "Method(#{@receiver_type}, "
			end
			
			if @return_type
				buffer << "returns: #{@return_type})"
			else
				buffer << ")"
			end
			
			return buffer
		end
		
		def parse(input)
			case input
			when ::String
				receiver_type.instance_method(input)
			when ::Proc
				input
			else
				raise ArgumentError, "Cannot coerce #{input.inpsect} into Method!"
			end
		end
	end
	
	def self.Method(receiver_type, *argument_types, returns: nil)
		Method.new(receiver_type, argument_types, returns)
	end
end
