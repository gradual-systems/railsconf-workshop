
set -e

puts "Accept packwerk dependencies"

echo "
dependencies:
- packs/user_facing_app
" >> package.yml

echo "
dependencies:
- packs/user_facing_app
" >> packs/admin/package.yml

bin/packwerk update

bin/packs visualize
mv packwerk.png ../06.png
find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../06_package_todo.yml



# find . -iname "account_actions_controller_spec.rb" | xargs bundle exec rspec spec/features
