set -x
set -e

echo "Run mastodon tests"

rm Gemfile
cp Gemfile_ORIGINAL Gemfile
rm Gemfile.lock
cp Gemfile.lock_ORIGINAL Gemfile.lock

echo "
gem 'packs-rails'
gem 'use_packs', group: %w(development test)
gem 'visualize_packwerk', group: %w(development test)
gem 'packwerk', group: %w(development test)
" >> Gemfile

bundle install

bin/packwerk validate

yarn --frozen-lockfile
# Should the above step fail on an error about encryption implementations 
# try to run the following line before running this script
# export NODE_OPTIONS=--openssl-legacy-provider

RAILS_ENV=test ./bin/rails db:setup

RAILS_ENV=development ./bin/rails db:setup

RAILS_ENV=development ./bin/rails assets:precompile

RAILS_ENV=test NODE_ENV=tests ./bin/rails assets:precompile


# If this script passes, you are set up to run mastodon tests. If you would 
# like to verify that all steps in the workshop lead to a green test suite 
# for mastodon, you can run a series of steps as follows (outputting rspec
# to files per step because the output gets kinda long)
#
# git checkout . && git clean -fd
# 
# ../mastodon-workshop/00.sh
# ../mastodon-workshop/07.sh && bundle exec rspec > 00_log.txt
# ../mastodon-workshop/01.sh && bundle exec rspec > 01_log.txt
# ../mastodon-workshop/02.sh && bundle exec rspec > 02_log.txt
# ../mastodon-workshop/03.sh && bundle exec rspec > 03_log.txt
# ../mastodon-workshop/04.sh && bundle exec rspec > 04_log.txt
# ../mastodon-workshop/05.sh && bundle exec rspec > 05_log.txt
# ../mastodon-workshop/06.sh && bundle exec rspec > 06_log.txt