
set -e

echo "Accept packwerk dependencies"

bin/packs add_dependency . packs/user_facing_app
bin/packs add_dependency packs/admin packs/user_facing_app
bin/packwerk update
which dot && bin/packs visualize || echo "Graphviz not installed. Run 'brew install graphviz' if you want to generate dependency graphs"
