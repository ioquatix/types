# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require_relative "generic"
require "json"

module Types
	# Represents a tuple type with specific item types.
	#
	# ```ruby
	# type = Types::Tuple(Types::String, Types::Integer)
	# type.parse(["foo", "42"]) # => ["foo", 42]
	# ```
	class Tuple
		include Generic
		
		# @parameter item_types [Array(Type)] The types of the tuple elements.
		def initialize(item_types)
			@item_types = item_types
		end
		
		# @returns [Array(Type)] The types of the tuple elements.
		attr :item_types
		
		# @returns [Boolean] true if this is a composite type.
		def composite?
			true
		end
		
		# Parses the input as a tuple with the specified item types.
		# @parameter input [Object] The value to parse.
		# @returns [Array] The parsed tuple.
		# @raises [ArgumentError] if the input cannot be converted to a tuple.
		def parse(input)
			case input
			when ::String
				return parse_values(parse_string(input))
			when ::Array
				return parse_values(input)
			else
				raise ArgumentError, "Cannot coerce #{input.inspect} into tuple!"
			end
		end
		
		# Resolves to the actual Ruby Array class, since there is no direct support for tuples in Ruby.
		# @returns [Class] The Array class.
		def resolve
			::Array
		end
		
		# @returns [String] the string representation of the tuple type.
		def to_s
			"Tuple(#{@item_types.join(', ')})"
		end
		
		# @returns [String] the RBS type string, e.g. `[String, Integer]`.
		def to_rbs
			"[#{@item_types.map(&:to_rbs).join(', ')}]"
		end
		
		private
		
		def parse_string(input)
			::JSON.parse("[#{input}]")
		end
		
		def parse_values(input)
			input.map.with_index{|value, index| @item_types[index].parse(value)}
		end
	end
	
	# Constructs a {Tuple} type from the given item types.
	# @parameter item_types [Array(Type)] The types of the tuple elements.
	# @returns [Tuple] a new {Tuple} type.
	def PARSER.Tuple(*item_types)
		Tuple.new(item_types)
	end
end
