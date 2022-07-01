# frozen_string_literal: true

require_relative "lib/types/version"

Gem::Specification.new do |spec|
	spec.name = "types"
	spec.version = Types::VERSION
	
	spec.summary = "A simple human-readable and Ruby-parsable type library."
	spec.authors = ["Samuel Williams"]
	spec.license = "MIT"
	
	spec.cert_chain  = ['release.cert']
	spec.signing_key = File.expand_path('~/.gem/release.pem')
	
	spec.homepage = "https://github.com/ioquatix/types"
	
	spec.metadata = {
		"funding_uri" => "https://github.com/sponsors/ioquatix/",
	}
	
	spec.files = Dir.glob('{lib}/**/*', File::FNM_DOTMATCH, base: __dir__)
end
