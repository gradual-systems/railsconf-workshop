set -e

brew install gnu-sed libidn libpq postgresql redis yarn ffmpeg imagemagick graphviz


export NVM_DIR=$HOME/.nvm;
source $NVM_DIR/nvm.sh;
nvm use 19 || nvm install 19 && nvm use 19 
# Problems with this step?
# If you get `Error: error:0308010C:digital envelope routines::unsupported`, 
# then run `export NODE_OPTIONS=--openssl-legacy-provider`

yarn --frozen-lockfile


export PATH="$HOME/.rbenv/shims:$PATH"
rbenv local 3.2.2 || rbenv install 3.2.2 && rbenv local 3.2.2 

bundle install
