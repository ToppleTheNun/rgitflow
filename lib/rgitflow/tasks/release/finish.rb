require 'rgitflow/tasks/task'

module RGitFlow
  module Tasks
    class Release
      class Finish < RGitFlow::Tasks::Task
        def initialize(git)
          super(git, 'finish', 'Finish a release branch', ['rgitflow', 'release'])
        end

        protected

        def run
          status 'Finishing release branch...'

          branch = @git.current_branch

          unless branch.start_with? RGitFlow::Config.options[:release]
            error 'Cannot finish a release branch unless you are in a release branch'
            abort
          end

          @git.branch(RGitFlow::Config.options[:master]).checkout
          @git.merge branch, "merging #{branch} into #{RGitFlow::Config.options[:master]}"

          @git.push
          if @git.is_remote_branch? branch
            @git.push('origin', branch, {:delete => true})
          end

          @git.branch(branch).delete

          @git.branch(RGitFlow::Config.options[:develop]).checkout

          status "Finished release branch #{branch}!"
        end
      end
    end
  end
end