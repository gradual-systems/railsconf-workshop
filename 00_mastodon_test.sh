
set -e

if [ "$1" = "ni" ]; then
    interactive=false
else
    interactive=true
fi

$interactive || echo "Script in non-interactive mode"
$interactive && echo "Script in interactive mode"




echo "\n\n\n################################################################################"
echo "################################################################################"
echo "################################################################################"
echo "\nSCRIPT 00: Installing mastodon + workshop dependencies."
echo "Also, verifying that the mastodon specs can run successfully"
$interactive && read -n 1 -p "Press any key to continue"
echo ""

echo "Installing system dependencies"
brew install    rbenv ruby-build gnu-sed libidn libpq postgresql redis yarn ffmpeg imagemagick

echo "Using rbenv to set ruby version to 3.2.1"
rbenv global 3.2.1

echo "Git checckout, clean, and pull"
git checkout .
git clean -fd

git pull --rebase

echo "Installing bundle"
bundle

bundle binstubs bundler --force

# nvm use 19

# From https://github.com/mastodon/mastodon/blob/main/.devcontainer/post-create.sh
# export NODE_OPTIONS=--openssl-legacy-provider

echo "Fetch Javascript dependencies"
yarn --frozen-lockfile

echo "Make Gemfile.lock pristine again"
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

find . -iname "account_actions_controller_spec.rb" | xargs bundle exec rspec spec/features
