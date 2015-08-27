module RGitFlow
  module Tasks
    class Hotfix
      autoload :Start, 'rgitflow/tasks/hotfix/start'
      autoload :Finish, 'rgitflow/tasks/hotfix/finish'

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
        Start.new @git
        Finish.new @git
      end
    end
  end
end