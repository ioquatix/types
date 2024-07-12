# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2022-2024, by Samuel Williams.

require_relative 'generic'

module Types
	class Class
		extend Generic
		include Generic
		
		def initialize(base)
			@base = base
		end
		
		attr :base
		
		def composite?
			true
		end
		
		def parse(input)
			klass = Object.const_get(input)
			
			if @base and !klass.ancestors.include?(@base)
				raise ArgumentError, "Class #{klass} is not a subclass of #{@base}!"
			end
			
			return klass
		end
		
		def self.composite?
			false
		end
		
		def self.parse(input)
			klass = Object.const_get(input)
			
			if !klass.is_a?(::Class)
				raise ArgumentError, "Class #{klass} is not a Class!"
			end
			
			return klass
		end
	end
	
	def self.Class(base = Object)
		Class.new(base)
	end
end
