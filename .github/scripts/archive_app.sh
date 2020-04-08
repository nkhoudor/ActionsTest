#!/bin/bash

set -eo pipefail

xcodebuild -workspace ActionsTest.xcworkspace \
            -scheme ActionsTest\ iOS \
            -sdk iphoneos \
            -configuration AppStoreDistribution \
            -archivePath $PWD/build/ActionsTest.xcarchive \
            clean archive | xcpretty
