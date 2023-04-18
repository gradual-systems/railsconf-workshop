
set -e

bin/packs create packs/user_facing_app

bin/packs move packs/user_facing_app app

gsed -i "s/'app'/'packs', 'user_facing_app', 'app'/" packs/user_facing_app/app/helpers/branding_helper.rb
gsed -i "s/'app'/'packs', 'user_facing_app', 'app'/" packs/user_facing_app/app/validators/reaction_validator.rb

gsed -i 's/- \./- packs\/user_facing_app/' packs/admin/package.yml

bin/packwerk update

bin/packs visualize
mv packwerk.png ../05.png
find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../05_package_todo.yml



# find . -iname "account_actions_controller_spec.rb" | xargs bundle exec rspec spec/features





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
