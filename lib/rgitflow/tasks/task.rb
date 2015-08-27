require 'rake'
require 'rake/tasklib'

module RGitFlow
  module Tasks
    class Task < ::Rake::TaskLib
      include RGitFlow::Printing
      include RGitFlow::Console
      # The namespaces of the task
      # @return [Array<String>] the task namespaces
      attr_accessor :namespaces

      # The name of the task
      # @return [String] the task name
      attr_accessor :name

      # The description of the task
      # @return [String] the task description
      attr_accessor :description

      # The dependencies of the task
      # @return [Array<String>] the dependencies of the task
      attr_accessor :dependencies

      # Runs a +Proc+ before the task
      # @return [Proc] a proc to call before running the task
      attr_accessor :before

      # Runs a +Proc+ after the task
      # @return [Proc] a proc to call after running the task
      attr_accessor :after

      def initialize(git, name, description, namespaces = ['rgitflow'],
                     dependencies = [])
        @git = git
        @name = name
        @description = description
        @namespaces = namespaces
        @dependencies = dependencies

        yield self if block_given?

        define
      end

      protected

      def define
        full_name = [*@namespaces, @name].join(":")

        desc @description unless ::Rake.application.last_comment
        task full_name => @dependencies do
          before.call if before.is_a?(Proc)
          run
          after.call if after.is_a?(Proc)
        end
      end

      def run
        raise NotImplementedError
      end
    end
  end
end