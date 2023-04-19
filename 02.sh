
set -e

echo "Fix some admin package dependencies"

bin/packs move packs/admin app/controllers/api/*/admin

bin/packwerk update

bin/packs visualize

find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../02_package_todo.yml
