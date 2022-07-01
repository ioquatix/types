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
