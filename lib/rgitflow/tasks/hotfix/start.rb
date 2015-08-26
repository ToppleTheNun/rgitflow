require 'rgitflow/tasks/task'

module RGitFlow
  module Tasks
    class Hotfix
      class Start < RGitFlow::Tasks::Task
        def initialize(git)
          super(git, 'start', 'Start a hotfix branch', ['rgitflow', 'hotfix'])
        end

        protected

        def run
          status 'Starting hotfix branch...'

          unless @git.current_branch == RGitFlow::Config.options[:master]
            error 'Cannot start a hotfix branch unless you are in the master branch'
            abort
          end

          branch = ENV['BRANCH']

          while branch.blank?
            error 'Cannot create a branch with an empty name!'
            prompt 'Please enter a name for your hotfix branch:'
            branch = STDIN.gets.chomp
          end

          branch = [RGitFlow::Config.options[:hotfix], branch].join('/')

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

          status "Started hotfix branch #{branch}!"
        end
      end
    end
  end
end