# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative 'any'

module Types
	# An extension module which allows constructing `Any` types using the `|` operator.
	module Generic
		# Create an instance of `Any` with the arguments as types.
		# @parameter other [Type] the alternative type to match.
		def | other
			Any.new([self, other])
		end
		
		# Whether a type contains nested types or not.
		def composite?
			false
		end
		
		def to_s
			self.name.rpartition('::').last
		end
	end
end
