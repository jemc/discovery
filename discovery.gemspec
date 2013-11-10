Gem::Specification.new do |s|
  s.name          = 'discovery'
  s.version       = '0.0.3'
  s.date          = '2013-10-09'
  s.summary       = "discovery"
  s.description   = "Device and service discovery."
  s.authors       = ["Joe McIlvain"]
  s.email         = 'joe.eli.mac@gmail.com'
  
  s.files         = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  
  s.require_path  = 'lib'
  s.homepage      = 'https://github.com/jemc/discovery/'
  s.licenses      = "Copyright 2013 Joe McIlvain. MIT Licensed."
  
  s.add_development_dependency('rake')
end