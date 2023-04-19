
set -e

echo "Accept packwerk dependencies"

bin/packs add_dependency . packs/user_facing_app
bin/packs add_dependency packs/admin packs/user_facing_app

bin/packwerk update

bin/packs visualize

find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../06_package_todo.yml
