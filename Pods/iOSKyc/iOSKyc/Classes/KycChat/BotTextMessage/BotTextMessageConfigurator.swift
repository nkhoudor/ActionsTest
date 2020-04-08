//
//  BotTextMessageConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 17/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycViews

class BotTextMessageConfigurator : BotTextMessageConfiguratorProtocol {
    
    let profile : BotTextMessageProfile
    
    init(profile : BotTextMessageProfile) {
        self.profile = profile
    }
    
    var warningColor: UIColor {
        return profile.warningColorProfile.color
    }
    
    var warningWidth: CGFloat {
        return profile.warningThickness
    }
    
    var warningCornerRadius: CGFloat {
        return profile.warningCornerRadius
    }
    
    var maskImageViewFactory: Factory<MaskImageView>? {
        return MaskImageView.getFactory(font: profile.maskImageFont, textColor: profile.maskImageTextColorProfile.color, maskColor: profile.maskImageMaskColorProfile.color, cornerRadius: profile.maskImageCornerRadius)
    }
    
    var textBackgroundColor: UIColor {
        return profile.backgroundColorProfile.color
    }
    
    var textContainerRadius: CGFloat {
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
    
    var textFont: UIFont {
        return profile.font
    }
    
    var textColor: UIColor {
        return profile.colorProfile.color
    }
}
