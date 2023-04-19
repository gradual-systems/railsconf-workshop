
set -e

echo "Fix some admin package dependencies"

bin/packs move packs/admin app/controllers/api/*/admin

bin/packwerk update
which dot && bin/packs visualize || echo "Graphviz not installed. Run 'brew install graphviz' if you want to generate dependency graphs"
