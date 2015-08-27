require 'rgitflow/printing'
require 'git'

module RGitFlow
  class Install
    include RGitFlow::Printing

    class << self
      attr_accessor :instance

      def install_tasks(opts = {})
        new(opts[:dir]).install
      end
    end

    attr_reader :dir, :git

    def initialize(dir = nil)
      @dir = dir || Dir.pwd
      @git = Git.open @dir
    end

    def install
      require 'rgitflow/tasks/scm/tasks'
      RGitFlow::Tasks::SCM.install_tasks :git => @git

      require 'rgitflow/tasks/feature/tasks'
      RGitFlow::Tasks::Feature.install_tasks :git => @git

      require 'rgitflow/tasks/hotfix/tasks'
      RGitFlow::Tasks::Hotfix.install_tasks :git => @git

      require 'rgitflow/tasks/release/tasks'
      RGitFlow::Tasks::Release.install_tasks :git => @git
    end
  end
end