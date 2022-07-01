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
	# A lambda that represents a function (or callable object).
	class Lambda
		include Generic
		
		def initialize(argument_types, return_type)
			@argument_types = argument_types
			@return_type = return_type
		end
		
		attr :argument_types
		attr :return_type
		
		def composite?
			true
		end
		
		def to_s
			if @return_type
				"Lambda(#{@argument_types.join(', ')}, returns: #{@return_type})"
			else
				"Lambda(#{@argument_types.join(', ')})"
			end
		end
		
		def parse(input)
			case input
			when ::String
				eval("lambda{#{input}}", TOPLEVEL_BINDING)
			when ::Proc
				input
			else
				raise ArgumentError, "Cannot coerce #{input.inpsect} into Lambda!"
			end
		end
	end
	
	def self.Lambda(*argument_types, returns: nil)
		Lambda.new(argument_types, returns)
	end
end
