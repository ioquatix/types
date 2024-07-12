# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative 'generic'

module Types
	class Array
		include Generic
		
		def initialize(item_type)
			@item_type = item_type
		end
		
		def composite?
			true
		end
		
		def map(values)
			values.map{|value| @item_type.parse(value)}
		end
		
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
		
		def to_s
			"Array(#{@item_type})"
		end
		
		private
		
		def parse_string(input)
			::JSON.parse("[#{input}]")
		end
		
		def parse_values(input)
			input.map{|value, index| @item_type.parse(value)}
		end
	end
	
	def self.Array(item_type = Any)
		Array.new(item_type)
	end
end
