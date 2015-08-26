require 'git/diff'

Git::Diff.class_eval do

  def diff_shortstat
    unless @cached_shortstat
      @cached_shortstat = @base.lib.diff_shortstat(@from, @to, {:path_limiter => @path})
    end
  end

end