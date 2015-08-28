require 'rgitflow/console'
require 'rgitflow/printing'

module RGitFlow
  class CLI
    include ::RGitFlow::Printing
    include ::RGitFlow::Console

    def cli(command)
      execute command
    end

    class << self
      def commandline(command)
        new.cli command
      end
    end
  end
end