require 'git/base'

Git::Base.class_eval do
  def dirty?
    dirt = diff.diff_shortstat.to_s.strip.chomp
    if dirt.blank?
      true
    end
    '0 files changed, 0 insertions(+), 0 deletions(-)' != dirt
  end
end