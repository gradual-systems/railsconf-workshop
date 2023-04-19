
set -e

echo "Merge 'messy middle' with root pack"

bin/packs move . packs/messy_middle

rm -rf packs/messy_middle

bin/packwerk update

bin/packs visualize

find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../04_package_todo.yml
