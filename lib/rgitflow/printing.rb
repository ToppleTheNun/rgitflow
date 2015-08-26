require 'ansi/constants'

module RGitFlow
  # Contains logic for printing messages to the console. Supports ANSI colors.
  # Inspired by rubygems-tasks' printing.rb
  module Printing
    # String to prepend to any status messages
    # @return [String] prefix for status messages
    STATUS_PREFIX = if $stdout.tty?
                      "#{ANSI::Constants::GREEN}#{ANSI::Constants::BRIGHT}>>>#{ANSI::Constants::CLEAR}"
                    else
                      '>>>'
                    end

    # String to prepend to any debug messages
    # @return [String] prefix for debug messages
    DEBUG_PREFIX = if $stderr.tty?
                     "#{ANSI::Constants::YELLOW}#{ANSI::Constants::BRIGHT}>>>#{ANSI::Constants::CLEAR}"
                   else
                     '>>>'
                   end

    # String to prepend to any error messages
    # @return [String] prefix for error messages
    ERROR_PREFIX = if $stderr.tty?
                     "#{ANSI::Constants::RED}#{ANSI::Constants::BRIGHT}>>>#{ANSI::Constants::CLEAR}"
                   else
                     '>>>'
                   end

    INPUT_PREFIX = if $stderr.tty?
                     "#{ANSI::Constants::BLUE}#{ANSI::Constants::BRIGHT}<<<#{ANSI::Constants::CLEAR}"
                   else
                     '<<<'
                   end

    protected

    # Prints a status message to the console
    # @param [String] message message to print to the console
    # @return [void]
    def status(message = '')
      if Rake.verbose
        STDOUT.puts "#{STATUS_PREFIX} #{message}"
      end
      nil
    end

    # Prints a debug message to the console
    # @param [String] message message to print to the console
    # @return [void]
    def debug(message = '')
      if Rake.verbose
        STDERR.puts "#{DEBUG_PREFIX} #{message}"
      end
      nil
    end

    # Prints an error message to the console
    # @param [String] message message to print to the console
    # @return [void]
    def error(message = '')
      STDERR.puts "#{ERROR_PREFIX} #{message}"
      nil
    end

    # Prints a prompt message to the console
    # @param [String] message message to print to the console
    # @return [void]
    def prompt(message = '')
      status message
      STDOUT.puts "#{INPUT_PREFIX} ".chomp
      nil
    end
  end
end