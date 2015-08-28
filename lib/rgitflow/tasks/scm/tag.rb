require 'rgitflow/tasks/scm/task'

module RGitFlow
  module Tasks
    class SCM
      class Tag < RGitFlow::Tasks::SCM::Task
        def initialize(git)
          super(git, 'tag', 'Tags the repository')
        end

        protected

        def run
          status 'Creating tag...'
          if dirty?
            error 'There are uncommitted changes in the repository!'

            print_status

            abort
          end
          status 'There are no uncommitted changes in the repository.'
          tag = ENV['TAG'] || ("#{RGitFlow::Config.options[:tag]}" %
              RGitFlow::VERSION.to_s)
          unless @git.tags.select { |t| t.name == tag }.length == 0
            error 'Cannot create a tag that already exists!'
            abort
          end
          @git.add_tag tag, { :m => "tagging as #{tag}" }

          @git.push 'origin', @git.current_branch, { :tags => true }

          status 'Successfully created tag!'
        end
      end
    end
  end
end