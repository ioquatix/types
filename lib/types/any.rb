# frozen_string_literal: true

# Copyright, 2020, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

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
