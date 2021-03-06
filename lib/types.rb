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

require_relative 'types/version'

require_relative 'types/any'
require_relative 'types/array'
require_relative 'types/block'
require_relative 'types/boolean'
require_relative 'types/class'
require_relative 'types/decimal'
require_relative 'types/float'
require_relative 'types/hash'
require_relative 'types/integer'
require_relative 'types/lambda'
require_relative 'types/method'
require_relative 'types/nil'
require_relative 'types/numeric'
require_relative 'types/string'
require_relative 'types/symbol'
require_relative 'types/tuple'

module Types
	VALID_SIGNATURE = /\A[a-zA-Z\(\):, |]+\z/
	
	def self.parse(signature)
		if signature =~ VALID_SIGNATURE
			eval(signature, binding)
		else
			raise ArgumentError, "Invalid type signature: #{signature.inspect}!"
		end
	end
end
