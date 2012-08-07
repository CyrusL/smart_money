Gem::Specification.new do |spec|
  spec.name = 'smart_money'
  spec.summary = "Adds some smartness around Money objects"
  spec.version = '1.0.0'
  spec.authors = ['Pivotal Labs']
  spec.email = 'nate+whitney@pivotallabs.com'

  spec.add_dependency 'money'
  spec.files = Dir['lib']
end