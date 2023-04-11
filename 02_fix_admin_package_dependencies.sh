
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





puts_h1 "SCRIPT 02: Fix admin package dependencies"
$interactive && read -n 1 -p "Press any key to continue"
puts ""


puts_h2 "Let's take a closer look at the root package_todo.yml"
$interactive && read -n 1 -p "Press any key to continue"
puts ""

$interactive && open package_todo.yml





puts_h2 "There is a bunch of admin code still in the root pack (In those API folders)"
puts_h2 "Move the API admin code into the admin package and update package todos"
$interactive && read -n 1 -p "Press any key to continue"
puts ""

bin/packs move packs/admin \
  app/controllers/api/v1/admin \
  app/controllers/api/v2/admin \

bin/packwerk update

echo 'VisualizePackwerk.package_graph!(Packs.all)' | RAILS_ENV=development bundle exec rails c
mv packwerk.png ../02-01_more_into_admin.png
find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../02-01_more_into_admin_package_todo.yml
$interactive && open ../02-01_more_into_admin.png





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

echo 'VisualizePackwerk.package_graph!(Packs.all)' | RAILS_ENV=development bundle exec rails c
mv packwerk.png ../02-02_extracted_messy_middle.png
find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../02-02_extracted_messy_middle_package_todo.yml
$interactive && open ../02-02_extracted_messy_middle.png

find . -iname "account_actions_controller_spec.rb" | xargs rspec spec/features





puts_h2 "If we move the messy middle into the back into the root..."
$interactive && read -n 1 -p "Press any key to continue"
puts ""

bin/packs move . \
  packs/messy_middle/app/workers/admin/account_deletion_worker.rb \
  packs/messy_middle/app/models/admin/action_log.rb \
  packs/messy_middle/app/models/admin/import.rb \
  packs/messy_middle/app/workers/admin/suspension_worker.rb \
  packs/messy_middle/app/workers/admin/unsuspension_worker.rb

rm -rf packs/messy_middle

bin/packwerk update

echo 'VisualizePackwerk.package_graph!(Packs.all)' | RAILS_ENV=development bundle exec rails c
mv packwerk.png ../02-03_user_facing_app_with_messy_middle.png
find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../02-03_user_facing_app_with_messy_middle_package_todo.yml
$interactive && open ../02-03_user_facing_app_with_messy_middle.png

find . -iname "account_actions_controller_spec.rb" | xargs rspec spec/features
