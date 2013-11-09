Gem::Specification.new do |s|
  s.name          = 'discovery'
  s.version       = '0.0.1'
  s.date          = '2013-10-08'
  s.summary       = "discovery"
  s.description   = "Device and service discovery."
  s.authors       = ["Joe McIlvain"]
  
  s.files         = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  
  s.require_path  = 'lib'
  
  s.add_development_dependency('rake')
end