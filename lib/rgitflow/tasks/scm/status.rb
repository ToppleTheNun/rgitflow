require 'rgitflow/tasks/task'

module RGitFlow
  module Tasks
    class SCM
      class Status < RGitFlow::Tasks::Task
        def initialize(git)
          super(git, 'status', 'Check the status of the repository', ['rgitflow', 'scm'])
        end

        protected

        def run
          if dirty?
            error 'There are uncommitted changes in the repository!'

            print_status

            abort
          else
            status 'There are no uncommitted changes in the repository.'
          end
        end

        def dirty?
          @git.dirty?
        end

        def print_status
          added = []
          modified = []
          deleted = []

          @git.diff.each { |f|
            if f.type == 'new'
              added << f
            elsif f.type == 'modified'
              modified << f
            elsif f.type == 'deleted'
              deleted << f
            end
          }

          debug 'added'
          added.each { |f| debug "  #{ANSI::Constants::GREEN}#{ANSI::Constants::BRIGHT}#{f.path}#{ANSI::Constants::CLEAR}" }

          debug 'modified'
          modified.each { |f| debug "  #{ANSI::Constants::YELLOW}#{ANSI::Constants::BRIGHT}#{f.path}#{ANSI::Constants::CLEAR}" }

          debug 'deleted'
          deleted.each { |f| debug "  #{ANSI::Constants::RED}#{ANSI::Constants::BRIGHT}#{f.path}#{ANSI::Constants::CLEAR}" }
        end
      end
    end
  end
end