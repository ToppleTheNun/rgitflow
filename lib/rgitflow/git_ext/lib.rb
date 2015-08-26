require 'git/lib'

Git::Lib.class_eval do
  def push(remote, branch = 'master', opts = {})
    # Small hack to keep backwards compatibility with the 'push(remote, branch, tags)' method signature.
    opts = {:tags => opts} if [true, false].include?(opts)

    arr_opts = []
    arr_opts << '--force'  if opts[:force] || opts[:f]
    arr_opts << '--delete' if opts[:delete] || opts[:d]
    arr_opts << remote

    command('push', arr_opts + [branch])
    command('push', ['--tags'] + arr_opts) if opts[:tags]
  end

  def diff_cached(obj1 = 'HEAD', obj2 = nil, opts = {})
    diff_opts = ['-p', '--cached']
    diff_opts << obj1
    diff_opts << obj2 if obj2.is_a?(String)
    diff_opts << '--' << opts[:path_limiter] if opts[:path_limiter].is_a? String

    command('diff', diff_opts)
  end
end