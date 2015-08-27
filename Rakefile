# encoding: utf-8

require 'rubygems'

begin
  require 'bundler'
rescue LoadError => e
  warn e.message
  warn "Run `gem install bundler` to install Bundler."
  exit -1
end

begin
  Bundler.setup(:development)
rescue Bundler::BundlerError => e
  warn e.message
  warn "Run `bundle install` to install missing gems."
  exit e.status_code
end

require 'rake'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

task :test    => [:spec]
task :default => [:spec]

desc 'Removes the tmp and pkg directories'
task :clean do
  pwd = Dir.pwd.to_s
  FileUtils.rm_rf Dir["#{pwd}/tmp"]
  FileUtils.rm_rf Dir["#{pwd}/pkg"]
end

require 'yard'
YARD::Rake::YardocTask.new
task :doc => [:yard]

require 'bundler/gem_tasks'

require 'rgitflow'
