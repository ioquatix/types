# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative 'generic'
require 'json'

module Types
	class Tuple
		include Generic
		
		def initialize(item_types)
			@item_types = item_types
		end
		
		attr :item_types
		
		def composite?
			true
		end
		
		def parse(input)
			case input
			when ::String
				return parse_values(parse_string(input))
			when ::Array
				return parse_values(input)
			else
				raise ArgumentError, "Cannot coerce #{input.inspect} into tuple!"
			end
		end
		
		def to_s
			"Tuple(#{@item_types.join(', ')})"
		end
		
		private
		
		def parse_string(input)
			::JSON.parse("[#{input}]")
		end
		
		def parse_values(input)
			input.map.with_index{|value, index| @item_types[index].parse(value)}
		end
	end
	
	def self.Tuple(*item_types)
		Tuple.new(item_types)
	end
end
