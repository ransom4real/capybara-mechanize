# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "capybara/mechanize/version"

Gem::Specification.new do |s|
  s.name = %q{bbc-capybara-mechanize-with-proxy}
  s.version = Capybara::Mechanize::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeroen van Dijk", "Matthew Crouch", "Voke Ransom Anighoro"]
  s.date = Date.today.to_s
  s.summary = %q{RackTest driver for Capybara with remote request support}
  s.description = %q{RackTest driver for Capybara, but with remote request support thanks to mechanize and added proxy configuration features}

  s.email = %q{ransom4real@gmail.com}
  s.files = Dir.glob("{lib,spec}/**/*") + %w(README.mdown)
  s.homepage = %q{https://github.com/ransom4real/capybara-mechanize}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  
  s.add_runtime_dependency(%q<mechanize>, ["~> 1.0.0"])
  s.add_runtime_dependency(%q<capybara>, ["~> 1.1.2"])
end
