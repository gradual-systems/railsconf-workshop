
set -e

puts_h1 () {
    echo "################################################################################"
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





puts_h1 "SCRIPT 02: Move all code into a user facing app package"
$interactive && read -n 1 -p "Press any key to continue"
puts ""

bin/packs create packs/user_facing_app

bin/packs move packs/user_facing_app app

gsed -i "s/'app'/'packs', 'user_facing_app', 'app'/" packs/user_facing_app/app/helpers/branding_helper.rb
gsed -i "s/'app'/'packs', 'user_facing_app', 'app'/" packs/user_facing_app/app/validators/reaction_validator.rb

gsed -i 's/- \./- packs\/user_facing_app/' packs/admin/package.yml
echo "
dependencies:
- packs/user_facing_app
" >> package.yml

bin/packwerk update

echo 'VisualizePackwerk.package_graph!(Packs.all)' | RAILS_ENV=development bundle exec rails c
mv packwerk.png ../03-01_user_facing_app_extracted.png
find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../03-01_user_facing_app_extracted_package_todo.yml
$interactive && open ../03-01_user_facing_app_extracted.png

find . -iname "account_actions_controller_spec.rb" | xargs rspec spec/features





puts_h2 "Let's also accept the dependecies from the admin app"
$interactive && read -n 1 -p "Press any key to continue"
puts ""

echo "
dependencies:
- packs/user_facing_app
" >> packs/admin/package.yml

bin/packwerk update

echo 'VisualizePackwerk.package_graph!(Packs.all)' | RAILS_ENV=development bundle exec rails c
mv packwerk.png ../03-02_admin_depends_on_use_facing_app.png
find . -name "package_todo.yml" -exec basename {} \; -exec cat {} \; > ../03-02_admin_depends_on_use_facing_app_package_todo.yml
$interactive && open ../03-02_admin_depends_on_use_facing_app.png

find . -iname "account_actions_controller_spec.rb" | xargs rspec spec/features


