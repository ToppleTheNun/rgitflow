require 'rake'

module RGitFlow
  module Console

    def included(base)
      base.extend Console
    end

    protected

    def execute(command, *arguments)
      show_command = [command, *arguments].join ' '

      if respond_to? 'debug'
        debug show_command
      end

      unless system(command, *arguments)
        if respond_to? 'error'
          error "Command failed: #{show_command}"
        end
        abort
      end

      nil
    end

    def invoke(name)
      Rake.application[name].reenable
      Rake.application[name].invoke
    end

    def task?(name)
      Rake::Task.task_defined? name
    end

    def multi_task(prefix, names)
      task prefix => names.map { |name| "#{prefix}:#{name}" }
    end

  end
end