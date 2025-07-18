# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2024-2025, by Samuel Williams.

require_relative "generic"

module Types
	# Represents an RBS interface type.
	#
	# ```ruby
	# type = Types::Interface.new("MyInterface")
	# type.to_rbs # => "_MyInterface"
	# type.to_s   # => "Interface(MyInterface)"
	# ```
	class Interface
		include Generic
		
		# @parameter name [String] The interface name.
		def initialize(name)
			@name = name
		end
		
		# @returns [String] The interface name.
		attr :name
		
		# @returns [Boolean] true if this is a composite type.
		def composite?
			true
		end
		
		# @returns [String] the string representation of the interface type.
		def to_s
			"Interface(#{@name})"
		end
		
		# @returns [String] the RBS interface representation with underscore prefix on the last component.
		def to_rbs
			if @name.include?("::")
				# For nested interfaces like "MyLibrary::MyInterface", return "MyLibrary::_MyInterface"
				parts = @name.split("::")
				parts[-1] = "_#{parts[-1]}"
				parts.join("::")
			else
				# For simple interfaces like "MyInterface", return "_MyInterface"
				"_#{@name}"
			end
		end
		
		# @returns [Boolean] true if other is an Interface with the same name.
		def == other
			other.is_a?(Interface) && @name == other.name
		end
		
		# @returns [Integer] hash code based on the name.
		def hash
			@name.hash
		end
	end
	
	# Constructs an {Interface} type from the given name.
	# @parameter name [String, Symbol] The interface name.
	# @returns [Interface] a new {Interface} type.
	def PARSER.Interface(name)
		Interface.new(name.to_s)
	end
end
