#!/bin/bash

set -eo pipefail

pod install

xcodebuild -workspace ActionsTest.xcworkspace \
            -scheme ActionsTest \
            -sdk iphoneos \
            -configuration AppStoreDistribution \
            -archivePath $PWD/build/ActionsTest.xcarchive \
            clean archive | xcpretty
