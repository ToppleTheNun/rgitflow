require 'rgitflow/tasks/task'

module RGitFlow
  module Tasks
    class Feature
      class Finish < RGitFlow::Tasks::Task
        def initialize(git)
          super(git, 'finish', 'Finish a feature branch', ['rgitflow', 'feature'])
        end

        protected

        def run
          status 'Finishing feature branch...'

          branch = @git.current_branch

          unless branch.start_with? RGitFlow::Config.options[:feature]
            error 'Cannot finish a feature branch unless you are in a feature branch'
            abort
          end

          @git.branch(RGitFlow::Config.options[:develop]).checkout
          @git.merge branch

          @git.push
          @git.push('origin', branch, {:delete => true})

          @git.branch(branch).delete

          status "Finished feature branch #{branch}!"
        end
      end
    end
  end
end