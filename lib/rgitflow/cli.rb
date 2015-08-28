require 'rgitflow/console'
require 'rgitflow/printing'

module RGitFlow
  class CLI
    include ::RGitFlow::Printing
    include ::RGitFlow::Console

    class << self
      def execute(command, *arguments)
        new.execute command, arguments
      end

      def invoke(name)
        new.invoke name
      end

      def task?(name)
        new.task? name
      end

      def multi_task(prefix, names)
        new.multi_task prefix, names
      end

      def status(message = '')
        new.status message
      end

      def debug(message = '')
        new.debug message
      end

      def error(message = '')
        new.error message
      end

      def prompt(message = '')
        new.prompt message
      end
    end
  end
end