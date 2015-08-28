require 'rgitflow/tasks/task'

module RGitFlow
  module Tasks
    class Hotfix
      class Finish < RGitFlow::Tasks::Task
        def initialize(git)
          super(git, 'finish', 'Finish a hotfix branch', ['rgitflow', 'hotfix'])
        end

        protected

        def run
          status 'Finishing hotfix branch...'

          branch = @git.current_branch

          unless branch.start_with? RGitFlow::Config.options[:hotfix]
            error 'Cannot finish a hotfix branch unless you are in a hotfix branch'
            abort
          end

          msg = %Q("merging #{branch} into #{RGitFlow::Config
                                                 .options[:master]}")

          @git.branch(RGitFlow::Config.options[:master]).checkout
          @git.merge branch

          begin
            @git.commit_all msg
          rescue
            status 'master branch is up-to-date'
          end

          @git.push
          if @git.is_remote_branch? branch
            @git.push('origin', branch, { :delete => true })
          end

          @git.branch(branch).delete

          status "Finished hotfix branch #{branch}!"
        end
      end
    end
  end
end