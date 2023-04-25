set -e

echo "Set up bare minimum for workshop. If you're interested in doing the advanced mode of this workshop (which involves setting up Mastodon so tests run successfully), check out script 07"

cat Gemfile | grep packwerk || bundle add packwerk --group 'development,test' --github 'gradual-systems/packwerk'
cat Gemfile | grep packs-rails || bundle add packs-rails
cat Gemfile | grep use_packs || bundle add use_packs --group 'development,test'
cat Gemfile | grep visualize_packwerk || bundle add visualize_packwerk --group 'development,test'

bundle install --local || bundle install

bundle binstubs bundler --force
bundle binstub use_packs
bundle binstub packwerk

echo "pack_paths:
  - packs/*
  - .
" > packs.yml

cat .rspec | grep "packs/rails" || echo "--require packs/rails/rspec" >> .rspec

bin/packwerk init
