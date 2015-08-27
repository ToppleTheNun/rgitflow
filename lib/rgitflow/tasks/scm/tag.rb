require 'rgitflow/tasks/task'

module RGitFlow
  module Tasks
    class SCM
      class Tag < RGitFlow::Tasks::Task
        def initialize(git)
          super(git, 'tag', 'Tags the repository',
                ['rgitflow', 'scm'])
        end

        protected

        def run
          status 'Creating tag...'
          if dirty?
            error 'There are uncommitted changes in the repository!'

            print_status

            abort
          else
            status 'There are no uncommitted changes in the repository.'
          end
          tag = ENV['TAG'] || "v#{RGitFlow::VERSION.to_s}"
          unless @git.tags.select { |t| t.name == tag }.length == 0
            error 'Cannot create a tag that already exists!'
            abort
          end
          @git.add_tag tag, { :m => "tagging as #{tag}" }

          @git.push 'origin', @git.current_branch, { :tags => true }

          status 'Successfully created tag!'
        end

        def dirty?
          @git.dirty?
        end

        def print_status
          added    = []
          modified = []
          deleted  = []

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
          msg = %Q(#{ANSI::Constants::GREEN}#{ANSI::Constants::BRIGHT}
          #{f.path}#{ANSI::Constants::CLEAR})
          added.each { |f| debug "  #{msg}" }

          debug 'modified'
          msg = %Q(#{ANSI::Constants::YELLOW}#{ANSI::Constants::BRIGHT}
          #{f.path}#{ANSI::Constants::CLEAR})
          modified.each { |f| debug "  #{msg}" }

          debug 'deleted'
          msg = %Q(#{ANSI::Constants::RED}#{ANSI::Constants::BRIGHT}
          #{f.path}#{ANSI::Constants::CLEAR})
          deleted.each { |f| debug "  #{msg}" }
        end
      end
    end
  end
end