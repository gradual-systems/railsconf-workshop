set -e

brew install gnu-sed libidn libpq postgresql redis yarn ffmpeg imagemagick graphviz


export NVM_DIR=$HOME/.nvm;
source $NVM_DIR/nvm.sh;
nvm use 19 || nvm install 19 && nvm use 19 
# Problems with this step?
# If you get `Error: error:0308010C:digital envelope routines::unsupported`, 
# then run `export NODE_OPTIONS=--openssl-legacy-provider`

export PATH="$HOME/.rbenv/shims:$PATH"
rbenv local 3.2.2 || rbenv install 3.2.2 && rbenv local 3.2.2 


# From https://github.com/mastodon/mastodon/blob/main/.devcontainer/post-create.sh

yarn --frozen-lockfile

git checkout -- Gemfile.lock

RAILS_ENV=test ./bin/rails db:drop
RAILS_ENV=test ./bin/rails db:setup

RAILS_ENV=development ./bin/rails db:drop 
RAILS_ENV=development ./bin/rails db:setup > /dev/null

RAILS_ENV=development ./bin/rails assets:precompile
RAILS_ENV=test ./bin/rails assets:precompile
# Problems with this step?
# Try running this instead
# `cp public/packs/manifest.json public/packs-test/manifest.json`


find . -iname "account_actions_controller_spec.rb" | xargs bundle exec rspec spec/features
