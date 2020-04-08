//
//  ErrorWarningInfoConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 11/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import Swinject

public class ErrorWarningInfoConfigurator : ErrorWarningInfoConfiguratorProtocol {
    
    let screenId : String
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var screenProfile: ScreenProfile = {
        return resolver.resolve(ScreenProfile.self, name: screenId)!
    }()
    
    init(screenId : String) {
        self.screenId = screenId
    }
    
    public var imageConfigurationFactory: ConfigurationFactory<UIImageView>? {
        return screenProfile.getAssetConfigurationFactory("ICON")
    }
    
    public var titleFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("HEADER")
    }
    
    public var subtitleFactory: Factory<UILabel>? {
        return screenProfile.getLabelFactory("SUBTITLE")
    }
    
    public var bottomTextViewFactory: Factory<UITextView>? {
        let factory : Factory<UITextView> = { [weak self] in
            let tv = UITextView()
            let label = self?.screenProfile.getLabelFactory("FIND_MORE")()
            tv.isEditable = false
            tv.isScrollEnabled = false
            tv.dataDetectorTypes = .link
            tv.isUserInteractionEnabled = true
            if let text = label?.text {
                tv.attributedText = try? NSAttributedString(HTMLString: text, font: label!.font, textColor: label!.textColor)
            }
            return tv
        }
        return factory
    }
    
    public var backgroundColor: UIColor = .white
}
