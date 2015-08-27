module RGitFlow
  module Tasks
    class SCM
      autoload :Status, 'rgitflow/tasks/scm/status'
      autoload :Tag, 'rgitflow/tasks/scm/tag'

      class << self
        attr_accessor :instance

        def install_tasks(opts = {})
          new(opts[:git]).install
        end
      end

      attr_reader :git

      def initialize(git = nil)
        @git = git || Git.open(Dir.pwd)
      end

      def install
        Status.new @git
        Tag.new @git
      end
    end
  end
end