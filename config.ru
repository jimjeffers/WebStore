# RAILS_ROOT/config.ru
ENV["GEM_HOME"]=%x{"source ~/.bash_profile ; rvm 1.9.1%pancake ; rvm gemdir"}.strip
require "config/environment"