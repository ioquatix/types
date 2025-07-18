# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require_relative "types/version"

require_relative "types/parser"

require_relative "types/any"
require_relative "types/array"
require_relative "types/block"
require_relative "types/boolean"
require_relative "types/class"
require_relative "types/decimal"
require_relative "types/enumerator"
require_relative "types/float"
require_relative "types/hash"
require_relative "types/integer"
require_relative "types/interface"
require_relative "types/lambda"
require_relative "types/method"
require_relative "types/named"
require_relative "types/nil"
require_relative "types/numeric"
require_relative "types/string"
require_relative "types/symbol"
require_relative "types/tuple"

# @namespace
module Types
	# Bare classes and modules should be convertable to RBS strings.
	Module.alias_method(:to_rbs, :to_s)
end
