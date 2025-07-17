# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require_relative "generic"

module Types
	# Represents an enumerator type with a specific item type.
	#
	# ```ruby
	# type = Types::Enumerator(Types::Integer)
	# type.parse([1, 2, 3].each) # => Enumerator for [1, 2, 3]
	# ```
	class Enumerator
		include Generic
		
		# @parameter item_type [Type] The type of the enumerator elements.
		def initialize(item_type)
			@item_type = item_type
		end
		
		# @returns [Boolean] true if this is a composite type.
		def composite?
			true
		end
		
		# Maps the given enumerator using the item type's parse method.
		# @parameter enumerator [Enumerator] The enumerator to map.
		# @returns [Enumerator] The mapped enumerator.
		def map(enumerator)
			enumerator.map{|value| @item_type.parse(value)}
		end
		
		# Parses the input as an enumerator with the specified item type.
		# @parameter input [Object] The value to parse.
		# @returns [Enumerator] The parsed enumerator.
		# @raises [ArgumentError] if the input cannot be converted to an enumerator.
		def parse(input)
			case input
			when ::Enumerator
				return input
			when ::Array
				return input.each
			else
				raise ArgumentError, "Cannot coerce #{input.inspect} into Enumerator!"
			end
		end
		
		# @returns [String] the string representation of the enumerator type.
		def to_s
			"Enumerator(#{@item_type})"
		end
		
		# @returns [String] the RBS type string, e.g. `Enumerator[String]`.
		def to_rbs
			"Enumerator[#{@item_type.to_rbs}]"
		end
		
		# Resolves to the actual Ruby Enumerator class.
		# @returns [Class] The Enumerator class.
		def resolve
			::Enumerator
		end
	end
	
	# Constructs an {Enumerator} type from the given item type.
	# @parameter item_type [Type] The type of the enumerator elements.
	# @returns [Enumerator] a new {Enumerator} type.
	def self.Enumerator(item_type = Any)
		Enumerator.new(item_type)
	end
end 