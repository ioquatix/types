# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2025, by Samuel Williams.

require_relative "generic"

module Types
	# Represents a named type that may not be defined yet.
	#
	# ```ruby
	# type = Types::Named("CustomType")
	# type.parse(value) # => value (pass-through)
	# ```
	class Named < Module
		include Generic
		
		# Initialize with a type name.
		# @parameter name [String] The name of the type.
		def initialize(name)
			@name = name
		end
		
		# @returns [String] The name of the type.
		attr :name
		
		# @returns [Boolean] whether the type is absolute.
		def absolute?
			@name.start_with?("::")
		end
		
		# @returns [Boolean] whether the type is relative.
		def relative?
			!absolute?
		end
		
		# Parses the input by passing it through unchanged.
		# @parameter input [Object] The value to parse.
		# @returns [Object] The input value unchanged.
		def parse(input)
			if resolved = self.resolve
				if resolved.respond_to?(:load)
					return resolved.load(input)
				elsif resolved.respond_to?(:parse)
					return resolved.parse(input)
				else
					raise ArgumentError, "Type #{@name} does not implement .load or .parse!"
				end
			else
				raise ArgumentError, "Unknown type: #{@name}"
			end
		end
		
		# Resolves the named type to the actual Ruby type if it exists.
		# @returns [Class | Module | Nil] The resolved Ruby type or nil if not found.
		def resolve(relative_to: Object)
			relative_to.const_get(@name)
		rescue NameError
			nil
		end
		
		def to_type
			resolve(relative_to: Types)
		end
		
		def parse(value)
			if type = self.to_type
				type.parse(value)
			else
				raise ArgumentError, "Cannot parse value #{value.inspect} with unknown type #{@name}!"
			end
		end
		
		# @returns [String] the RBS type string using the name.
		def to_rbs
			@name
		end
		
		# @returns [String] the string representation of the named type.
		def to_s
			@name
		end
		
		def inspect
			"<#{self.class} #{@name}>"
		end
		
		# @returns [Boolean] true if other is a Named type with the same name.
		def == other
			other.is_a?(Named) && @name == other.name
		end
		
		# @returns [Integer] hash code based on the name.
		def hash
			@name.hash
		end
		
		# @returns [Boolean] whether this type is composite.
		def composite?
			false
		end
		
		# Handles missing constants by creating nested Named types.
		# This allows parsing of nested type signatures like Foo::Bar.
		# @parameter name [Symbol] The name of the missing constant.
		# @returns [Named] A Named type representing the nested unknown type.
		def const_missing(name)
			Named.new("#{@name}::#{name}")
		end
	end
	
	# Constructs a {Named} type with the given name.
	# @parameter name [String] The name of the type.
	# @returns [Named] a new {Named} type.
	def PARSER.Named(name)
		Named.new(name)
	end
end
