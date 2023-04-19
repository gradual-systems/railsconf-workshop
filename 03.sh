
set -e

echo "Create pack for 'messy middle'"

bin/packs create packs/messy_middle

bin/packs move packs/messy_middle `../mastodon-workshop/03_find_files_to_root_violations.rb`

bin/packwerk update

which dot && bin/packs visualize || echo "Graphviz not installed. Run 'brew install graphviz' if you want to generate dependency graphs"

find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../03_package_todo.yml
