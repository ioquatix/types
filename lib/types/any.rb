# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

module Types
	# Represents a union of multiple types. The first type to match the input is used. If no types are provided, this matches any type or value.
	#
	# ```ruby
	# type = Types::Any(Types::String, Types::Integer)
	# ```
	class Any
		# Initialize the instance with an array of types.
		# @parameter types [Array] The array of types.
		def initialize(types)
			@types = types
		end
		
		# @returns [Any] a new {Any} with the other type appended.
		# @parameter other [Type] The type instance to append.
		def | other
			self.class.new([*@types, other])
		end
		
		# @returns [Boolean] true if any of the listed types is composite.
		def composite?
			@types.any? {|type| type.composite?}
		end
		
		# Parses the input using the listed types in order, returning the first one that succeeds.
		# @parameter input [String] the input to parse.
		# @returns [Object] the parsed value.
		# @raises [ArgumentError] if no type can parse the input.
		def parse(input)
			# If there are no types, we can just return the input.
			return input if @types.empty?
			
			@types.each do |type|
				return type.parse(input)
			rescue => error
				last_error = error
			end
			
			if last_error
				raise last_error
			else
				raise ArgumentError, "Unable to parse input #{input.inspect}!"
			end
		end
		
		# Accepts any value as a class type.
		def self.parse(value)
			value
		end
		
		# @returns [String] a readable string representation of the listed types.
		def to_s
			if @types.empty?
				"Any()"
			else
				"#{@types.join(' | ')}"
			end
		end
		
		# Returns the RBS type string for the union of the listed types. If there are no types, it returns `untyped`.
		# @returns [String] the RBS type string, e.g. `String | Integer`.
		def to_rbs
			if @types.empty?
				"untyped"
			else
				@types.map(&:to_rbs).join(" | ")
			end
		end
	end
	
	# Constructs an {Any} type from the given types.
	# @parameter types [Array(Type)] The types to include in the union.
	# @returns [Any] a new {Any} type.
	def self.Any(*types)
		Any.new(types)
	end
end
