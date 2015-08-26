require 'git/base'

Git::Base.class_eval do
  def dirty?
    puts '0 files changed, 0 insertions(+), 0 deletions(-)'
    puts diff.diff_shortstat.to_s.strip
    '0 files changed, 0 insertions(+), 0 deletions(-)' != diff.diff_shortstat.to_s.strip
  end
end