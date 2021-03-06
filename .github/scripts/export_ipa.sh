#!/bin/bash

set -eo pipefail

xcodebuild -archivePath $PWD/build/ActionsTest.xcarchive \
            -exportOptionsPlist ActionsTest/exportOptions.plist \
            -exportPath $PWD/build \
            -allowProvisioningUpdates \
            -exportArchive | xcpretty
