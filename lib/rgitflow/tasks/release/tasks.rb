module RGitFlow
  module Tasks
    class Release
      autoload :Start, 'rgitflow/tasks/release/start'
      autoload :Finish, 'rgitflow/tasks/release/finish'

      class << self
        attr_accessor :instance

        def install_tasks(opts = {})
          new(opts[:git]).install
        end
      end

      attr_reader :git

      def initialize(git = nil)
        @git = git || Git.open(Pathname.pwd)
      end

      def install
        Start.new @git
        Finish.new @git
      end
    end
  end
end