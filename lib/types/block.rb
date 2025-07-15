# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative "method"

module Types
	# Represents a block (Proc) type with argument and return types.
	#
	# ```ruby
	# type = Types::Block(Types::String, Types::Integer, returns: Types::String)
	# type.to_s # => "Block(String, Integer, returns: String)"
	# ```
	class Block
		include Generic
		
		# @parameter argument_types [Array(Type)] The types of the block arguments.
		# @parameter return_type [Type | Nil] The return type of the block.
		def initialize(argument_types, return_type)
			@argument_types = argument_types
			@return_type = return_type
		end
		
		# @returns [Array(Type)] The types of the block arguments.
		attr :argument_types
		
		# @returns [Type | Nil] The return type of the block.
		attr :return_type
		
		# @returns [Boolean] true if this is a composite type.
		def composite?
			true
		end
		
		# @returns [String] the string representation of the block type.
		def to_s
			if @return_type
				"Block(#{@argument_types.join(', ')}, returns: #{@return_type})"
			else
				"Block(#{@argument_types.join(', ')})"
			end
		end
		
		# @returns [String] the RBS type string, e.g. `Proc[(String, Integer) -> String]`.
		def to_rbs
			argument_types = @argument_types.map(&:to_rbs).join(", ")
			return_type = @return_type ? @return_type.to_rbs : "void"
			
			return "Proc[(#{argument_types}) -> #{return_type}]"
		end
	end
	
	# Constructs a {Block} type from the given argument and return types.
	# @parameter argument_types [Array(Type)] The types of the block arguments.
	# @parameter returns [Type | Nil] The return type of the block.
	# @returns [Block] a new {Block} type.
	def self.Block(*argument_types, returns: nil)
		Block.new(argument_types, returns)
	end
end
