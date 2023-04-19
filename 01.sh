set -x
set -e

echo "Create admin pack"

bin/packs create packs/admin
bin/packs move packs/admin app/*/admin 
bin/packwerk update
which dot && bin/packs visualize || echo "Graphviz not installed. Run 'brew install graphviz' if you want to generate dependency graphs"
