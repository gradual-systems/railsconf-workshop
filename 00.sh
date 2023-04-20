set -e

echo "Set up bare minimum for workshop. If you're interested in doing the advanced mode of this workshop (which involves setting up Mastodon so tests run successfully), check out branch XYZ"

echo "
gem 'packs-rails'

gem 'use_packs', group: %w(development test)
gem 'visualize_packwerk', group: %w(development test)

# We're using this fork for the Mastodon Gradual Modularization workshop only. 
# In a real-life situation you should replace the following line with commented out line below
gem 'packwerk', 
  github: 'gradual-systems/packwerk', 
  branch: 'main', group: %w(development test)
# gem 'packwerk', group: %w(development test)
" >> Gemfile

bundle install

bundle binstubs bundler --force
bundle binstub use_packs
bundle binstub packwerk

echo "pack_paths:
  - packs/*
  - .
" > packs.yml

echo "
--require packs/rails/rspec
" >> .rspec

bin/packwerk init
