//
//  PassportMaskCameraConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 19/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import Swinject
import iOSKycViews

class PassportMaskCameraConfigurator : MaskCameraConfiguratorProtocol {
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var screenProfile: ScreenProfile = {
        return resolver.resolve(ScreenProfile.self, name: "CAMERA")!
    }()
    
    var cameraType: CameraType = .back
    
    var takeButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("BUTTON_CAMERA_TAKE")
    }
    
    var retakeButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("BUTTON_CAMERA_RETAKE")
    }
    
    var topLabelFactory: Factory<UILabel>? {
        return screenProfile.getLabelFactory("PASSPORT")
    }
    
    var secondaryLabelFactory: Factory<UILabel>? {
        return screenProfile.getLabelFactory("FRONTPAGE")
    }
    
    var photoButtonImageFactory: ConfigurationFactory<UIImageView> {
        return screenProfile.getAssetConfigurationFactory("PHOTO")
    }
    
    var maskType: MaskCameraType = .rectangle
    
    var maskColor: UIColor = UIColor.black.withAlphaComponent(0.7)
    
    
}
