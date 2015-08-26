require 'rgitflow/version'
require 'rgitflow/tasks/task_helpers'

module RGitFlow
  # The root path for RGitFlow source libraries
  ROOT = File.expand_path(File.dirname(__FILE__))
end

# Load Ruby core extension classes
Dir.glob(File.join(RGitFlow::ROOT, 'rgitflow', 'core_ext', '*.rb')).each do |file|
  require file
end

['autoload', 'globals'].each do |file|
  require File.join(RGitFlow::ROOT, 'rgitflow', file)
end

# Load YARD configuration options (and plugins)
RGitFlow::Config.load