
set -e

echo "\n\n\n################################################################################"
echo "################################################################################"
echo "################################################################################"
echo "\nSCRIPT 00: Installing mastodon + workshop dependencies."
echo "Also, verifying that the mastodon specs can run successfully"
read -n 1 -p "Press any key to continue"
echo ""

brew install gnu-sed libidn libpq postgresql redis yarn ffmpeg imagemagick


git checkout .
git clean -fd

git pull --rebase

bundle

bundle binstubs bundler --force

# nvm use 19

# From https://github.com/mastodon/mastodon/blob/main/.devcontainer/post-create.sh

export NODE_OPTIONS=--openssl-legacy-provider

# Fetch Javascript dependencies
yarn install

# Make Gemfile.lock pristine again
git checkout -- Gemfile.lock

RAILS_ENV=test ./bin/rails db:drop

# [re]create, migrate, and seed the test database
RAILS_ENV=test ./bin/rails db:setup

RAILS_ENV=development ./bin/rails db:drop

# [re]create, migrate, and seed the development database
RAILS_ENV=development ./bin/rails db:setup

# Precompile assets for development
RAILS_ENV=development ./bin/rails assets:precompile

# Precompile assets for test
# RAILS_ENV=test NODE_ENV=tests ./bin/rails assets:precompile
cp public/packs/manifest.json public/packs-test/manifest.json 

bundle exec rspec spec/controllers/about_controller_spec.rb
