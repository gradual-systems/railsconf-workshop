# mastodon-workshop
Ruby At Scale Workshop with Mastodon

## Usage

Check out this repo next to a mastodon repo, like so:

```
tree . -L 1
.
├── mastodon
└── mastodon-workshop
```

### Setting up mastodon?

Run our first script:
`../mastodon-workshop/00_mastodon_test.sh`

Please file an issue or open a PR if you find any issues with the script!

### Creating the admin package?
`../mastodon-workshop/01_create_admin_package.sh`

### Creating the user app package?

Run in the mastodon directory in interactive mode
`../mastodon-workshop/02_create_user_app_package.sh`

### Want to run in non-interactive mode?

Run in the mastodon directory in NON-interactive mode

```
NI="y" ../mastodon-workshop/01_create_admin_package.sh
```
