require 'rgitflow/tasks/task'

module RGitFlow
  module Tasks
    class Feature
      class Start < RGitFlow::Tasks::Task
        def initialize(git)
          super(git, 'start', 'Start a feature branch', ['rgitflow', 'feature'])
        end

        protected

        def run
          status 'Starting feature branch...'

          unless @git.current_branch == RGitFlow::Config.options[:develop]
            error 'Cannot create feature branch unless on development branch'
            abort
          end

          branch = ENV['BRANCH']

          while branch.blank?
            error 'Cannot create a branch with an empty name!'
            prompt 'Please enter a name for your feature branch:'
            branch = STDIN.gets.chomp
          end

          branch = [RGitFlow::Config.options[:feature], branch].join('/')

          if @git.is_local_branch? branch
            error 'Cannot create a branch that already exists locally'
            abort
          end

          if @git.is_remote_branch? branch
            error 'Cannot create a branch that already exists remotely'
            abort
          end

          @git.branch(branch).create
          @git.branch(branch).checkout

          status "Started feature branch #{branch}!"
        end
      end
    end
  end
end