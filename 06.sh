
set -e

echo "Accept packwerk dependencies"

bin/packs add_dependency . packs/user_facing_app
bin/packs add_dependency packs/admin packs/user_facing_app

bin/packwerk update

bin/packs visualize
cp packwerk.png ../06.png
find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../06_package_todo.yml



# find . -iname "account_actions_controller_spec.rb" | xargs bundle exec rspec spec/features
