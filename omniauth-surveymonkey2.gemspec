# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'lib/omniauth/survey_monkey/version'

Gem::Specification.new do |s|
  s.name     = 'omniauth-surveymonkey2'
  s.version  = OmniAuth::SurveyMonkey::VERSION
  s.authors  = ['Michael Berkovich']
  s.email    = ['theiceberk@gmail.com']
  s.summary  = 'SurveyMonkey strategy for OmniAuth'
  s.homepage = 'https://github.com/berk/omniauth-surveymonkey'
  s.description = 'SurveyMonkey strategy for SSO using OmniAuth framework'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
  s.licenses    = 'MIT-LICENSE'

  s.add_runtime_dependency 'omniauth-oauth2', '~> 1.1'
end
