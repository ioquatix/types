# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require_relative "generic"

module Types
	# Represents an array type with a specific item type.
	#
	# ```ruby
	# type = Types::Array(Types::Integer)
	# type.parse(["1", "2"]) # => [1, 2]
	# ```
	class Array
		include Generic
		
		# @parameter item_type [Type] The type of the array elements.
		def initialize(item_type)
			@item_type = item_type
		end
		
		# @returns [Boolean] true if this is a composite type.
		def composite?
			true
		end
		
		# Maps the given values using the item type's parse method.
		# @parameter values [Array] The values to map.
		# @returns [Array] The mapped array.
		def map(values)
			values.map{|value| @item_type.parse(value)}
		end
		
		# Parses the input as an array with the specified item type.
		# @parameter input [Object] The value to parse.
		# @returns [Array] The parsed array.
		# @raises [ArgumentError] if the input cannot be converted to an array.
		def parse(input)
			case input
			when ::String
				return parse_values(parse_string(input))
			when ::Array
				return parse_values(input)
			else
				raise ArgumentError, "Cannot coerce #{input.inspect} into Array!"
			end
		end
		
		# @returns [String] the string representation of the array type.
		def to_s
			"Array(#{@item_type})"
		end
		
		# @returns [String] the RBS type string, e.g. `Array[String]`.
		def to_rbs
			"Array[#{@item_type.to_rbs}]"
		end
		
		# Resolves to the actual Ruby Array class.
		# @returns [Class] The Array class.
		def resolve
			::Array
		end
		
		private
		
		def parse_string(input)
			::JSON.parse("[#{input}]")
		end
		
		def parse_values(input)
			input.map{|value, index| @item_type.parse(value)}
		end
	end
	
	# Constructs an {Array} type from the given item type.
	# @parameter item_type [Type] The type of the array elements.
	# @returns [Array] a new {Array} type.
	def self.Array(item_type = Any)
		Array.new(item_type)
	end
end
