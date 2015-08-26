require 'rgitflow/printing'
require 'git'

module RGitFlow
  module Tasks
    class TaskHelper
      include RGitFlow::Printing
      include Rake::DSL if defined? Rake::DSL

      class << self
        attr_accessor :instance

        def install_tasks(opts = {})
          new(opts[:dir], opts[:name]).install
        end

        def gemspec(&block)
          gemspec = instance.gemspec
          block.call(gemspec) if block
          gemspec
        end
      end

      attr_reader :base, :git

      def initialize(base = nil)
        @base = base || Pathname.pwd
        @git = Git.open @base
      end

      def install
        desc 'Checks the status of the Git repository'
        task 'rgitflow:scm:status' do
          if dirty?
            error 'There are uncommitted changes in the repository!'

            print_status

            abort
          end
        end

        # Creates an alias of validate to rgitflow:scm:status
        task 'validate' => ['rgitflow:scm:status']
        
        desc 'Start a feature branch with its name specified by the environment variable BRANCH'
        task 'rgitflow:feature:start' => ['validate'] do
          status 'Starting feature branch...'

          if ENV['BRANCH'].blank?
            error 'Cannot create a branch with an empty name'
            abort
          end

          branch = RGitFlow::Config

          if @git.branches.local.select { |b| b.name == branch }
            error 'Cannot create a branch that already exists locally'
            abort
          end

          if @git.branches.remote.select { |b| b.name == branch }
            error 'Cannot create a branch that already exists remotely'
            abort
          end

          @git.branch branch

          status "Started feature branch #{branch}!"
        end

        desc 'Finish a feature branch with its name specified by the environment variable BRANCH'
        task 'rgitflow:feature:finish' => ['validate'] do
          status 'Finishing feature branch...'

          if ENV['BRANCH'].blank?
            error 'Cannot finish a branch with an empty name'
            abort
          end

          branch = "feature/#{ENV['BRANCH']}"

          if @git.branches.local.select{ |b| b.name == branch }.length <= 0
            error 'Cannot finish a branch that does not exist locally'
            abort
          end

          @git.branch 'master'
          @git.merge branch
          @git.branch(branch).delete

          @git.push('origin', branch)
          @git.push

          status "Finished feature branch #{branch}!"
        end

        desc 'Start a release branch with its name specified by the environment variable BRANCH'
        task 'rgitflow:release:start' => ['validate'] do

        end

        desc 'Finish a release branch with its name specified by the environment variable BRANCH'
        task 'rgitflow:release:finish' => ['validate'] do

        end

        desc 'Start a hotfix branch with its name specified by the environment variable BRANCH'
        task 'rgitflow:hotfix:start' => ['validate'] do

        end

        desc 'Finish a hotfix branch with its name specified by the environment variable BRANCH'
        task 'rgitflow:hotfix:finish' => ['validate'] do

        end

        TaskHelper.instance = self
      end

      private

      def dirty?
        @git.diff.size > 0
      end

      def print_status
        status @git.status.pretty.to_s
      end

      def run(command, *arguments)
        show_command = [command, *arguments].join(' ')

        debug show_command

        unless system(command, *arguments)
          error "Command failed: #{show_command}"
          abort
        end

        nil
      end

      def gem_cmd(command, *arguments)
        run 'gem', command, arguments
      end

      def bundler_cmd(command, *arguments)
        run 'bundler', command, arguments
      end

      def invoke(name)
        Rake.application[name].invoke
      end

      def task?(name)
        Rake::Task.task_defined? name
      end

      def multi_task(prefix, names)
        task prefix => names.map { |name| "#{prefix}:#{name}" }
      end

      def gemspec_tasks(name)
        multi_task name, @project.gemspecs.keys
      end
    end
  end
end

class Object
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
end