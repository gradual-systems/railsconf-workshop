
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

if [ "$1" = "ni" ]; then
    interactive=false
else
    interactive=true
fi

$interactive || echo "Script in non-interactive mode"
$interactive && echo "Script in interactive mode"





puts_h1 "SCRIPT 01: Extracting an admin package within the mastodon app"
puts ""






puts_h2 "Moving admin code (identified by anything in a app/*/admin folder) into a pack and running tests"
$interactive && read -n 1 -p "Press any key to continue"
puts ""

gsed '/use_packs/d' Gemfile

echo "
gem 'use_packs'
gem 'visualize_packwerk', path: '../visualize_packwerk'
" >> Gemfile

echo "pack_paths:
  - packs/*
  - .
" > packs.yml

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

find . -iname "account_actions_controller_spec.rb" | xargs rspec spec/features || puts_h2 "Spec execution failed because packs directory is being ignored by Rails"





puts_h2 "Installing packs-rails to make Rails pick up the packs directory"
$interactive && read -n 1 -p "Press any key to continue"
puts ""

echo "
gem 'packs-rails'
" >> Gemfile

bundle

echo "
--require packs/rails/rspec
--color
--require spec_helper
--format Fuubar
" > .rspec

find . -iname "account_actions_controller_spec.rb" | xargs rspec spec/features





echo "TESTS PASS!!! Let's see what packwerk says"
$intputs_h2eractive && read -n 1 -p "Press any key to continue"
puts ""

bin/packwerk update


puts_h2 "Check out package_todo.yml and packs/admin/package_todo.yml"
puts "Not many violations in the root, YIKES!! Lots of violations in the admin... which is expected"
$interactive && read -n 1 -p "Press any key to continue"
puts ""

$interactive && open package_todo.yml
$interactive && open packs/admin/package_todo.yml





puts_h2 "Let's accept that the admin package depends on the root package"
$interactive && read -n 1 -p "Press any key to continue"
puts ""

echo "
dependencies:
- .
" >> packs/admin/package.yml

bin/packwerk update



puts_h2 "Let's take a closer look at the root package_todo.yml"
$interactive && read -n 1 -p "Press any key to continue"
puts ""

$interactive && open package_todo.yml

puts_h2 "There is a bunch of admin code still in the root pack (In those API folders)"
$interactive && read -n 1 -p "Press any key to continue"
puts ""





puts_h2 "Move the API admin code into the admin package and update package todos"
$interactive && read -n 1 -p "Press any key to continue"
puts ""

bin/packs move packs/admin \
  app/controllers/api/v1/admin \
  app/controllers/api/v2/admin \

bin/packwerk update

$interactive && open package_todo.yml





puts_h2 "Let's see if can't move the remaining violation causing files into a pack and avoid violations..."
$interactive && read -n 1 -p "Press any key to continue"
puts ""

bin/packs create packs/messy_middle

bin/packs move packs/messy_middle \
  packs/admin/app/workers/admin/account_deletion_worker.rb \
  packs/admin/app/models/admin/action_log.rb \
  packs/admin/app/models/admin/import.rb \
  packs/admin/app/workers/admin/suspension_worker.rb \
  packs/admin/app/workers/admin/unsuspension_worker.rb

bin/packwerk update

echo "If there are no more package_todo.yml files, we're good"

find . -iname "package_todo.yml"