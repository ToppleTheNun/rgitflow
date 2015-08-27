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
end