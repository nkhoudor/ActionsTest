#!/bin/sh
set -eo pipefail

gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/Actions_Test_Dist.mobileprovision.mobileprovision ./.github/secrets/Actions_Test_Dist.mobileprovision.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/nik_dist.p12 ./.github/secrets/nik_dist.p12.gpg

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

cp ./.github/secrets/Actions_Test_Dist.mobileprovision.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/Actions_Test_Dist.mobileprovision.mobileprovision


security create-keychain -p "" build.keychain
security import ./.github/secrets/nik_dist.p12 -t agg -k ~/Library/Keychains/build.keychain -P "test" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain
