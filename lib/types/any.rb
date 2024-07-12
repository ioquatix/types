# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

module Types
	# An ordered list of types. The first type to match the input is used.
	#
	#	```ruby
	#	type = Bake::Types::Any(Bake::Types::String, Bake::Types::Integer)
	#	```
	#
	class Any
		# Initialize the instance with an array of types.
		# @parameter types [Array] the array of types.
		def initialize(types)
			@types = types
		end
		
		# Create a copy of the current instance with the other type appended.
		# @parameter other [Type] the type instance to append.
		def | other
			self.class.new([*@types, other])
		end
		
		# Whether any of the listed types is a composite type.
		# @returns [Boolean] true if any of the listed types is `composite?`.
		def composite?
			@types.any?{|type| type.composite?}
		end
		
		# Parse an input string, trying the listed types in order, returning the first one which doesn't raise an exception.
		# @parameter input [String] the input to parse, e.g. `"5"`.
		def parse(input)
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
		
		# As a class type, accepts any value.
		def self.parse(value)
			value
		end
		
		# Generate a readable string representation of the listed types.
		def to_s
			"#{@types.join(' | ')}"
		end
	end
	
	# A type constructor.
	#
	#	```ruby
	#	Any(Integer, String)
	#	```
	#
	# See [Any.initialize](#Bake::Types::Any::initialize).
	#
	def self.Any(*types)
		Any.new(types)
	end
end
