# @private
def __p(path) File.join(RGitFlow::ROOT, 'rgitflow', *path.split('/')); end

module RGitFlow
  module Tasks
    autoload :TaskHelper, __p('tasks/task_helpers')
  end

  autoload :Config, __p('config')
  autoload :Printing, __p('printing')
end