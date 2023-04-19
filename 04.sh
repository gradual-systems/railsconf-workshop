
set -e

echo "Merge 'messy middle' with root pack"

bin/packs move . packs/messy_middle
rm -rf packs/messy_middle
bin/packwerk update
which dot && bin/packs visualize || echo "Graphviz not installed. Run 'brew install graphviz' if you want to generate dependency graphs"
