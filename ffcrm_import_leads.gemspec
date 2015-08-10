$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ffcrm_import_leads/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ffcrm_import_leads"
  s.version     = FfcrmImportLeads::VERSION
  s.authors     = ["Gabriel Rios"]
  s.email       = ["gabrielfalcaorios@gmail.com"]
  s.licenses    = ["MIT"]
  s.homepage    = "http://github.com/orbitalimpact/Fat-Free-CRM-Lead-Importer"
  s.summary     = "A simple plugin to import leads into Fat Free CRM"
  s.description = "A simple plugin to import leads into Fat Free CRM"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.3"
  s.add_dependency "fat_free_crm"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency "mysql2"
end
