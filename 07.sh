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

bundle exec rspec
