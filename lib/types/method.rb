# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require_relative "generic"

module Types
	# Represents a method type attached to a receiver type.
	#
	# ```ruby
	# type = Types::Method(Types::String, Types::Integer, returns: Types::String)
	# type.to_s # => "Method(String, Integer, returns: String)"
	# ```
	class Method
		include Generic
		
		# @parameter receiver_type [Type] The type of the receiver.
		# @parameter argument_types [Array(Type)] The types of the method arguments.
		# @parameter return_type [Type | Nil] The return type of the method.
		def initialize(receiver_type, argument_types, return_type)
			@receiver_type = receiver_type
			@argument_types = argument_types
			@return_type = return_type
		end
		
		# @returns [Type] The type of the receiver.
		attr :receiver_type
		# @returns [Array(Type)] The types of the method arguments.
		attr :argument_types
		# @returns [Type | Nil] The return type of the method.
		attr :return_type
		
		# @returns [Boolean] true if this is a composite type.
		def composite?
			true
		end
		
		# @returns [String] the string representation of the method type.
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
		
		# @returns [String] the RBS type string, e.g. `Method[Receiver, (Args) -> Return]`.
		def to_rbs
			argument_types = @argument_types.map(&:to_rbs).join(", ")
			return_type = @return_type ? @return_type.to_rbs : "void"
			
			return "Method[#{@receiver_type}, (#{argument_types}) -> #{return_type}]"
		end
		
		# Parses the input as a method or proc.
		# @parameter input [Object] The value to parse.
		# @returns [UnboundMethod, Proc] the parsed method or proc.
		# @raises [ArgumentError] if the input cannot be converted to a method.
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
	
	# Constructs a {Method} type from the given receiver, argument, and return types.
	# @parameter receiver_type [Type] The type of the receiver.
	# @parameter argument_types [Array(Type)] The types of the method arguments.
	# @parameter returns [Type | Nil] The return type of the method.
	# @returns [Method] a new {Method} type.
	def self.Method(receiver_type, *argument_types, returns: nil)
		Method.new(receiver_type, argument_types, returns)
	end
end
