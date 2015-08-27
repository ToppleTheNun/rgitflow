require 'rgitflow/tasks/task'

module RGitFlow
  module Tasks
    class Release
      class Start < RGitFlow::Tasks::Task
        def initialize(git)
          super(git, 'start', 'Start a release branch', ['rgitflow', 'release'])
        end

        protected

        def run
          status 'Starting release branch...'

          unless @git.current_branch == RGitFlow::Config.options[:develop]
            error 'Cannot create release branch unless on development branch'
            abort
          end

          branch = [RGitFlow::Config.options[:release], RGitFlow::VERSION.to_s].join('/')

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

          status "Started release branch #{branch}!"
        end
      end
    end
  end
end