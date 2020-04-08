//
//  BotLoadingMessageConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 21/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import MaterialComponents.MaterialActivityIndicator
import iOSKycViews

class BotLoadingMessageConfigurator : BotLoadingMessageConfiguratorProtocol {
    
    let profile : BotLoadingMessageProfile
    
    init(profile : BotLoadingMessageProfile) {
        self.profile = profile
    }
    
    var activityIndicatorFactory : Factory<MDCActivityIndicator> {
        return MDCActivityIndicator.getFactory(color: profile.indicatorColorProfile.color)
    }
    
    var containerBackgroundColor: UIColor {
        return profile.backgroundColorProfile.color
    }
    
    var containerRadius: CGFloat {
        return profile.textContainerRadius
    }
    
    var verticalMargin: CGFloat {
        return profile.verticalMargin
    }
    
    var horizontalMargin: CGFloat {
        return profile.horizontalMargin
    }
    
    var avatarMargin: CGFloat {
        return profile.avatarMargin
    }
    
    var botAvatarImageFactory: ConfigurationFactory<UIImageView> {
        return profile.avatar.getAssetConfigurationFactory()
    }
}
