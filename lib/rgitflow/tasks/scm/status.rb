require 'rgitflow/tasks/scm/task'

module RGitFlow
  module Tasks
    class SCM
      class Status < RGitFlow::Tasks::SCM::Task
        def initialize(git)
          super(git, 'status', 'Check the status of the repository')
        end

        protected

        def run
          if dirty?
            error 'There are uncommitted changes in the repository!'

            print_status

            abort
          end
          status 'There are no uncommitted changes in the repository.'
        end
      end
    end
  end
end