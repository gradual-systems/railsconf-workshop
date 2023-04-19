
set -e

echo "Create user facing app pack"

bin/packs create packs/user_facing_app

bin/packs move packs/user_facing_app app

# gsed -i "s/'app'/'packs', 'user_facing_app', 'app'/" packs/user_facing_app/app/helpers/branding_helper.rb
# gsed -i "s/'app'/'packs', 'user_facing_app', 'app'/" packs/user_facing_app/app/validators/reaction_validator.rb

bin/packwerk update

bin/packs visualize

find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../05_package_todo.yml
