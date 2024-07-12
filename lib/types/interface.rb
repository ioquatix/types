# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2024, by Samuel Williams.

require_relative 'generic'

module Types
	module Interface
		extend Generic
		
		def initialize(methods)
			@methods = methods
		end
		
		attr :methods
		
		def composite?
			true
		end
		
		def to_s
			buffer = ::String.new
			
			buffer << "Interface("
			
			if @methods&.any?
				buffer << @methods.join(', ')
			end
			
			buffer << ")"
			
			return buffer
		end
		
		def valid?(instance)
			@methods.all? do |method|
				instance.respond_to?(method)
			end
		end
		
		def self.parse(input)
			Object.const_get(input).new
		end
	end
	
	def self.Interface(*methods)
		Interface.new(methods)
	end
end
