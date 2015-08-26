# @private
def __p(path) File.join(RGitFlow::ROOT, 'rgitflow', *path.split('/')); end

module RGitFlow
  autoload :Config, __p('config')
  autoload :Printing, __p('printing')
  autoload :Install, __p('install')
end