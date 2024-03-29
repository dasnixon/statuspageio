lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "statuspageio/version"

Gem::Specification.new do |spec|
  spec.name          = "statuspageio"
  spec.version       = Statuspageio::VERSION
  spec.authors       = ["Chris Nixon"]
  spec.email         = ["chris.d.nixon@gmail.com"]

  spec.summary       = %q{Ruby API wrapper for Statuspage.io.}
  spec.homepage      = "https://github.com/dasnixon/statuspageio"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.21"

  spec.add_development_dependency 'bundler', '~> 2.1', '>= 2.1.0'
  spec.add_development_dependency 'rake', '~> 12.3', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.10.0'
  spec.add_development_dependency 'rubocop', '~> 1.18'
  spec.add_development_dependency 'webmock', '~> 3.13.0'
end
