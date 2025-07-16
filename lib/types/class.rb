# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2025, by Samuel Williams.

require_relative "generic"

module Types
	# Represents a class type, optionally constrained to a base class.
	#
	# ```ruby
	# type = Types::Class(String)
	# type.parse("Array") # => Array
	# ```
	class Class
		extend Generic
		include Generic
		
		# @parameter base [Class] The base class constraint.
		def initialize(base)
			@base = base
		end
		
		# @returns [Class] the base class constraint.
		attr :base
		
		# @returns [Boolean] true if this is a composite type.
		def composite?
			true
		end
		
		# Parses the input as a class, optionally checking the base class constraint.
		# @parameter input [String] The class name to parse.
		# @returns [Class] the parsed class.
		# @raises [ArgumentError] if the class is not a subclass of the base.
		def parse(input)
			klass = Object.const_get(input)
			
			if @base and !klass.ancestors.include?(@base)
				raise ArgumentError, "Class #{klass} is not a subclass of #{@base}!"
			end
			
			return klass
		end
		
		# @returns [Boolean] false for the class type itself.
		def self.composite?
			false
		end
		
		# @returns [String] the RBS type string, e.g. `Class`.
		def to_rbs
			"Class"
		end
		
		# Parses the input as a class, raising if not a class.
		# @parameter input [String] The class name to parse.
		# @returns [Class] the parsed class.
		# @raises [ArgumentError] if the constant is not a class.
		def self.parse(input)
			klass = Object.const_get(input)
			
			if !klass.is_a?(::Class)
				raise ArgumentError, "Class #{klass} is not a Class!"
			end
			
			return klass
		end
		
		# Resolves to the actual Ruby Class class.
		# @returns [Class] The Class class.
		def self.resolve
			::Class
		end
	end
	
	# Constructs a {Class} type with an optional base class constraint.
	# @parameter base [Class] The base class constraint.
	# @returns [Class] a new {Class} type.
	def self.Class(base = Object)
		Class.new(base)
	end
end
