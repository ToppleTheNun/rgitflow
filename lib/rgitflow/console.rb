require 'rake'

module RGitFlow
  module Console

    protected

    def execute(command)
      if respond_to? 'debug'
        debug command.to_s
      end

      unless system(command.to_s)
        if respond_to? 'error'
          error "Command failed: #{command.to_s}"
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