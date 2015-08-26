# @private
def __p(path) File.join(RGitFlow::ROOT, 'rgitflow', *path.split('/')); end

module RGitFlow
  autoload :Config, __p('config')
end