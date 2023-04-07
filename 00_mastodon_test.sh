set -e

puts_h1 () {
    echo "\n\n\n################################################################################"
    echo "### " $1
    echo "################################################################################"
    echo ""
}

puts_h2 () {
    echo ""
    echo $1 | sed -e 's/^/*** /'
}

puts () {
  echo $1 | sed -e 's/^/    /'
}

if [ "$1" = "NI" ] || [ "$NI" = "y" ]; then
    interactive=false
else
    interactive=true
fi

$interactive || puts_h2 "Script in non-interactive mode"
$interactive && puts_h2 "Script in interactive mode"



puts_h1 "SCRIPT 00: Installing mastodon + workshop dependencies."
puts "Also, verifying that the mastodon specs can run successfully"
puts ""

puts_h2 "Installing system dependencies"
brew install    gnu-sed libidn libpq postgresql redis yarn ffmpeg imagemagick

puts_h2 "Using nvm to set node version to 19"
export NVM_DIR=$HOME/.nvm;
source $NVM_DIR/nvm.sh;
nvm use 19 || nvm install 19 && nvm use 19 

puts_h2 "Using rbenv to set ruby version to 3.2.2"
export PATH="$HOME/.rbenv/shims:$PATH"
rbenv local 3.2.2 || rbenv install 3.2.2 && rbenv local 3.2.2 

puts_h2 "Git checkout, clean, and pull"
git checkout .
git clean -fd

git pull --rebase

puts_h2 "Installing bundle"
bundle | grep Installing || echo "No new gems were installed"

bundle binstubs bundler --force

# From https://github.com/mastodon/mastodon/blob/main/.devcontainer/post-create.sh

puts_h2 "Fetch Javascript dependencies"
yarn --frozen-lockfile

puts_h2 "Make Gemfile.lock pristine again"
git checkout -- Gemfile.lock

puts_h2 "[re]create, migrate, and seed the test database"
RAILS_ENV=test ./bin/rails db:drop
RAILS_ENV=test ./bin/rails db:setup

puts_h2 "[re]create, migrate, and seed the development database"
RAILS_ENV=development ./bin/rails db:drop 
RAILS_ENV=development ./bin/rails db:setup > /dev/null

puts_h2 "Precompile assets for development"
RAILS_ENV=development ./bin/rails assets:precompile

puts_h2 "Precompile assets for test"
# Copying the dev file seems to work in more cases then precompiling in test env
# RAILS_ENV=test NODE_ENV=tests ./bin/rails assets:precompile
cp public/packs/manifest.json public/packs-test/manifest.json 

find . -iname "account_actions_controller_spec.rb" | xargs bundle exec rspec spec/features
