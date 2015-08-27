# @private
def __p(path) File.join(RGitFlow::ROOT, 'rgitflow', *path.split('/')); end

module RGitFlow
  autoload :Config, __p('config')
  autoload :Console, __p('console')
  autoload :Install, __p('install')
  autoload :Printing, __p('printing')
end