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

          msg = %Q("merging #{branch} into #{RGitFlow::Config.options[:develop]}")

          @git.branch(RGitFlow::Config.options[:develop]).checkout
          @git.merge branch

          begin
            @git.commit_all msg
          rescue
            status 'develop branch is up-to-date'
          end

          @git.push
          if @git.is_remote_branch? branch
            @git.push('origin', branch, { :delete => true })
          end

          @git.branch(branch).delete

          status "Finished feature branch #{branch}!"
        end
      end
    end
  end
end