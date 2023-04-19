
set -e

echo "Fix some admin package dependencies"

bin/packs move packs/admin \
  app/controllers/api/v1/admin \
  app/controllers/api/v2/admin \

bin/packwerk update

bin/packs visualize
cp packwerk.png ../02.png
find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../02_package_todo.yml
