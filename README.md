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

Run in the mastodon directory in interactive mode

```
../mastodon-workshop/00_mastodon_test.sh && \
../mastodon-workshop/01_create_admin_package.sh && \
../mastodon-workshop/02_create_user_app_package.sh
```

Run in the mastodon directory in NON-interactive mode

```
../mastodon-workshop/00_mastodon_test.sh ni && \
../mastodon-workshop/01_create_admin_package.sh ni && \
../mastodon-workshop/02_create_user_app_package.sh ni 
```
