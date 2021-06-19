source "https://rubygems.org"

ruby "2.7.1"

gem "xcodeproj"
gem "httparty"
gem "fastlane"
gem "xcov"
gem "danger"
gem "danger-junit"
gem "danger-swiftlint"
gem "danger-swiftformat"
gem "danger-xcov"
gem "jazzy"
gem 'cocoapods-generate'
gem 'slather'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
