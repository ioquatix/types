# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require_relative "generic"

module Types
	# Represents a hash type with key and value types.
	#
	# ```ruby
	# type = Types::Hash(Types::String, Types::Integer)
	# type.parse({"foo" => "42"}) # => {"foo" => 42}
	# ```
	class Hash
		include Generic
		
		# @parameter key_type [Type] The type of the hash keys.
		# @parameter value_type [Type] The type of the hash values.
		def initialize(key_type, value_type)
			@key_type = key_type
			@value_type = value_type
		end
		
		# @returns [Boolean] true if this is a composite type.
		def composite?
			true
		end
		
		# Parses the input as a hash with the specified key and value types.
		# @parameter input [Object] The value to parse.
		# @returns [Hash] The parsed hash.
		# @raises [ArgumentError] if the input cannot be converted to a hash.
		def parse(input)
			case input
			when ::String
				return parse_values(parse_string(input))
			when ::Hash
				return parse_values(input)
			else
				raise ArgumentError, "Cannot coerce #{input.inspect} into Hash!"
			end
		end
		
		# @returns [String] the string representation of the hash type.
		def to_s
			"Hash(#{@key_type}, #{@value_type})"
		end
		
		# @returns [String] the RBS type string, e.g. `{ String => Integer }`.
		def to_rbs
			"{ #{@key_type.to_rbs} => #{@value_type.to_rbs} }"
		end
		
		private
		
		def parse_string(input)
			::JSON.parse("{#{input}}")
		end
		
		def parse_values(input)
			input.map{|key, value| [@key_type.parse(key), @value_type.parse(value)]}.to_h
		end
	end
	
	# Constructs a {Hash} type from the given key and value types.
	# @parameter key_type [Type] The type of the hash keys.
	# @parameter value_type [Type] The type of the hash values.
	# @returns [Hash] a new {Hash} type.
	def self.Hash(key_type, value_type)
		Hash.new(key_type, value_type)
	end
end
