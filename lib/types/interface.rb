# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2024, by Samuel Williams.

require_relative "generic"
require_relative "method"
require_relative "any"

module Types
	# Represents an interface type, defined by required method names.
	#
	# ```ruby
	# type = Types::Interface(
	# 	foo: Method.new(Any, returns: Any),
	# 	bar: Method.new(Any, returns: Any)
	# )
	# type.valid?(obj) # => true if obj responds to :foo and :bar
	# ```
	class Interface
		extend Generic
		
		# @parameter methods [Array(Symbol)] The required method names.
		def initialize(methods)
			@methods = methods
		end
		
		# @returns [Array(Symbol)] The required method names.
		attr :methods
		
		# @returns [Boolean] true if this is a composite type.
		def composite?
			true
		end
		
		# @returns [String] the string representation of the interface type.
		def to_s
			buffer = ::String.new
			
			buffer << "Interface("
			
			if @methods&.any?
				first = true
				@methods.each do |name, method|
					if first
						first = false
					else
						buffer << ", "
					end
					
					buffer << "#{name}: #{method}"
				end
			end
			
			buffer << ")"
			
			return buffer
		end
		
		# Checks if the given instance responds to all required methods.
		# @parameter instance [Object] The object to check.
		# @returns [Boolean] true if the instance responds to all methods.
		def valid?(instance)
			@methods.all? do |name, method|
				instance.respond_to?(name)
			end
		end
		
		# Parses the input as an object and checks if it matches the interface.
		# @parameter input [Object] The value to parse.
		# @returns [Object] the input if it matches the interface.
		# @raises [ArgumentError] if the input does not match the interface.
		def parse(input)
			case input
			when ::String
				instance = eval(input)
			else
				instance = input
			end
			
			if valid?(instance)
				return instance
			else
				raise ArgumentError, "Cannot coerce #{input.inspect} into #{self}!"
			end
		end
	end
	
	# Constructs an {Interface} type from the given method names.
	# @parameter methods [Array(Symbol)] The required method names.
	# @returns [Interface] a new {Interface} type.
	def self.Interface(*names, **methods)
		# This is a deprecated way to create an interfaces with names only. Ideally, we actually need to know the methods.
		names.each do |name|
			methods[name.to_sym] = Method.new(Any(), [], Any())
		end
		
		Interface.new(methods)
	end
end
