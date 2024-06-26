fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android test

```sh
[bundle exec] fastlane android test
```

Runs all the tests

### android internal_draft

```sh
[bundle exec] fastlane android internal_draft
```

Submit a new draft Build to Google Play Internal test

### android internal

```sh
[bundle exec] fastlane android internal
```

Submit a new draft Build to Google Play Internal test

### android beta

```sh
[bundle exec] fastlane android beta
```

Submit a new draft Build to Google Play Closed Testing

### android production

```sh
[bundle exec] fastlane android production
```

Submit a new draft Build to Google Play Production

### android update_metadata

```sh
[bundle exec] fastlane android update_metadata
```

Update metadata and images for all languages

### android deploy

```sh
[bundle exec] fastlane android deploy
```

Deploy a new version to the Google Play

### android promote

```sh
[bundle exec] fastlane android promote
```

Promote a new version to the Google Play

### android iapp

```sh
[bundle exec] fastlane android iapp
```

First Upload to Internal and then Production

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
