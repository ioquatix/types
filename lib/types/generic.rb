# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative "any"

module Types
	# An extension module which allows constructing `Any` types using the `|` operator.
	#
	# ```ruby
	# type = Types::String | Types::Integer
	# ```
	module Generic
		# Create an instance of `Any` with the arguments as types.
		# @parameter other [Type] the alternative type to match.
		# @returns [Any] a new {Any} type representing the union.
		def | other
			Any.new([self, other])
		end
		
		# @returns [String] the RBS representation of this type as a string.
		# By default, this is the same as to_s, but can be overridden by composite types.
		def to_rbs
			to_s
		end
		
		# @returns [Boolean] whether a type contains nested types or not.
		def composite?
			false
		end
		
		# @returns [String] the string representation of the type.
		def to_s
			self.name.rpartition("::").last
		end
	end
end
