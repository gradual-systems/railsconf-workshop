
set -e

echo "Create user facing app pack"

bin/packs create packs/user_facing_app

bin/packs move packs/user_facing_app app

gsed -i "s/'app'/'packs', 'user_facing_app', 'app'/" packs/user_facing_app/app/helpers/branding_helper.rb
gsed -i "s/'app'/'packs', 'user_facing_app', 'app'/" packs/user_facing_app/app/validators/reaction_validator.rb

bin/packwerk update

bin/packs visualize
cp packwerk.png ../05.png
find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../05_package_todo.yml



# find . -iname "account_actions_controller_spec.rb" | xargs bundle exec rspec spec/features
