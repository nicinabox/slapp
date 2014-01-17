# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "slapp"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nic Aitch"]
  s.date = "2014-01-17"
  s.description = "Parse Slackaware PACKAGES.TXT files with ease"
  s.email = "nic@nicinabox.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/slapp.rb",
    "lib/slapp/helpers.rb",
    "lib/slapp/package.rb",
    "lib/slapp/parser.rb",
    "slapp.gemspec",
    "spec/parser_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/PACKAGES.TXT"
  ]
  s.homepage = "http://github.com/nicinabox/slapp"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "Parse Slackaware PACKAGES.TXT files with ease"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end

