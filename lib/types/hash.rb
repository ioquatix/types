# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative 'generic'

module Types
	class Hash
		include Generic
		
		def initialize(key_type, value_type)
			@key_type = key_type
			@value_type = value_type
		end
		
		def composite?
			true
		end
		
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
		
		def to_s
			"Hash(#{@key_type}, #{@value_type})"
		end
		
		private
		
		def parse_string(input)
			::JSON.parse("{#{input}}")
		end
		
		def parse_values(input)
			input.map{|key, value| [@key_type.parse(key), @value_type.parse(value)]}.to_h
		end
	end
	
	def self.Hash(key_type, value_type)
		Hash.new(key_type, value_type)
	end
end
