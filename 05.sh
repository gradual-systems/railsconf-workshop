
set -e

echo "Create user facing app pack"

bin/packs create packs/user_facing_app
bin/packs move packs/user_facing_app app
bin/packs move . packs/user_facing_app/app/javascript

bin/packwerk update
which dot && bin/packs visualize || echo "Graphviz not installed. Run 'brew install graphviz' if you want to generate dependency graphs"
