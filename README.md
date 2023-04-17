# mastodon-workshop
Ruby At Scale Workshop with Mastodon

## Prerequisites

* We built this script for macos
* You must have [nvm](https://github.com/nvm-sh/nvm#install--update-script) and [rbenv](https://github.com/rbenv/rbenv#installation) installed

## Before the workshop

### Setting up your machine to run mastodon

```
# Check out the gradual.systems fork of mastodon
git clone --depth=1 git@github.com:gradual-systems/mastodon.git 

git clone git@github.com:gradual-systems/mastodon-workshop.git

pushd mastodon
../mastodon-workshop/00_mastodon_test.sh
popd
```

Note that your repos will be next to each other on the filesystem:
```
tree . -L 1
.
├── mastodon
└── mastodon-workshop
```

## During the workshop

### Running the workshop code

There are more scripts in the repo, indexed 01, 02, and 03. We'll use these throughout the workshop.

### Running in non-interactive mode

You can run all scripts in NON-interactive mode like so:

```
export NI="y"
../mastodon-workshop/SCRIPT_YOU_WANT_TO_RUN
unset NI
```
