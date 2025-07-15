# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative "generic"

module Types
	# Represents a lambda (function) type with argument and return types.
	#
	# ```ruby
	# type = Types::Lambda(Types::String, Types::Integer, returns: Types::String)
	# type.to_s # => "Lambda(String, Integer, returns: String)"
	# ```
	class Lambda
		include Generic
		
		# @parameter argument_types [Array(Type)] The types of the lambda arguments.
		# @parameter return_type [Type | Nil] The return type of the lambda.
		def initialize(argument_types, return_type)
			@argument_types = argument_types
			@return_type = return_type
		end
		
		# @returns [Array(Type)] The types of the lambda arguments.
		attr :argument_types
		# @returns [Type | Nil] The return type of the lambda.
		attr :return_type
		
		# @returns [Boolean] true if this is a composite type.
		def composite?
			true
		end
		
		# @returns [String] the string representation of the lambda type.
		def to_s
			if @return_type
				"Lambda(#{@argument_types.join(', ')}, returns: #{@return_type})"
			else
				"Lambda(#{@argument_types.join(', ')})"
			end
		end
		
		# Parses the input as a lambda/proc.
		# @parameter input [Object] The value to parse.
		# @returns [Proc] the parsed lambda/proc.
		# @raises [ArgumentError] if the input cannot be converted to a lambda.
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
	
	# Constructs a {Lambda} type from the given argument and return types.
	# @parameter argument_types [Array(Type)] The types of the lambda arguments.
	# @parameter returns [Type | Nil] The return type of the lambda.
	# @returns [Lambda] a new {Lambda} type.
	def self.Lambda(*argument_types, returns: nil)
		Lambda.new(argument_types, returns)
	end
end
