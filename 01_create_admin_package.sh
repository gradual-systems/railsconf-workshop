
set -e

puts_h1 () {
    echo "  \n\n\n################################################################################"
    echo "### " $1
    echo "################################################################################"
    echo ""
}

puts_h2 () {
    puts ""
    echo $1 | sed -e 's/^/*** /'
}

puts () {
  echo $1 | sed -e 's/^/    /'
}

if [ "$1" = "NI" ] || [ "$NI" = "y" ]; then
    interactive=false
else
    interactive=true
fi

$interactive || echo "Script in non-interactive mode"
$interactive && echo "Script in interactive mode"





puts_h1 "SCRIPT 01: Extracting an admin package within the mastodon app"
$interactive && read -n 1 -p "Press any key to continue"
puts ""






puts_h2 "Moving admin code (identified by anything in a app/*/admin folder) into a pack and running tests"
$interactive && read -n 1 -p "Press any key to continue"
puts ""

gsed '/use_packs/d' Gemfile

echo "
gem 'use_packs'
gem 'packs-rails'
gem 'visualize_packwerk', path: '../visualize_packwerk'
" >> Gemfile

echo "pack_paths:
  - packs/*
  - .
" > packs.yml

echo "
--require packs/rails/rspec
--color
--require spec_helper
--format Fuubar
" > .rspec

bundle

bundle binstubs bundler --force
bundle binstub use_packs
bundle binstub packwerk

bin/packwerk init

# Exluding a file that doesn't sit well with packwerk
gsed -i 's/# exclude\:/exclude\:/' packwerk.yml
gsed -i '/exclude\:/a- lib\/templates\/rails\/post_deployment_migration\/migration.rb' packwerk.yml

bin/packs create packs/admin

bin/packs move packs/admin \
  app/chewy/admin \
  app/controllers/admin \
  app/helpers/admin \
  app/javascript/admin \
  app/lib/admin \
  app/mailers/admin \
  app/models/admin \
  app/policies/admin \
  app/presenters/admin \
  app/serializers/admin \
  app/services/admin \
  app/validators/admin \
  app/views/admin \
  app/workers/admin

find . -iname "account_actions_controller_spec.rb" | xargs rspec spec/features





echo "TESTS PASS!!! Let's see what packwerk says"
$interactive && read -n 1 -p "Press any key to continue"
puts ""

bin/packwerk update

echo 'VisualizePackwerk.package_graph!(Packs.all)' | RAILS_ENV=development bundle exec rails c
mv packwerk.png ../01-01_admin_extracted.png
find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../01-01_admin_extracted_package_todo.yml
$interactive && open ../01-01_admin_extracted.png





puts_h2 "Check out package_todo.yml and packs/admin/package_todo.yml"
puts "Not many violations in the root, YIKES!! Lots of violations in the admin... which is expected"
$interactive && read -n 1 -p "Press any key to continue"
puts ""
