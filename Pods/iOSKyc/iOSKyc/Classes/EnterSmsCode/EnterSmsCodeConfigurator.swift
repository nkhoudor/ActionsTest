//
//  PhoneRegistrationConfigurator.swift
//  iOSKycViews_Example
//
//  Created by Nik on 05/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import iOSKycViews
import iOSBaseViews
import MaterialComponents.MaterialActivityIndicator

class EnterSmsCodeConfigurator : EnterCodeConfiguratorProtocol {
    
    let viewModel : PhoneRegistrationViewModel
    let screenProfile: ScreenProfile
    let numTextFieldStyleProfile: NumTextFieldStyleProfile
    let mainColorProfile: ColorProfile
    
    init(viewModel : PhoneRegistrationViewModel, screenProfile: ScreenProfile, numTextFieldStyleProfile: NumTextFieldStyleProfile, mainColorProfile: ColorProfile) {
        self.viewModel = viewModel
        self.screenProfile = screenProfile
        self.numTextFieldStyleProfile = numTextFieldStyleProfile
        self.mainColorProfile = mainColorProfile
    }
    
    var numTextFieldFactory: Factory<NumTextField> {
        return numTextFieldStyleProfile.factory
    }
    
    var titleLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("HEADER")
    }
    
    var subtitleLabelFactory: Factory<UILabel> {
        let factory : Factory<UILabel> = { [weak self] in
            guard let label = self?.screenProfile.getLabelFactory("SEND_TO")() else { return UILabel() }
            label.text = "\(label.text ?? "")\(self?.viewModel.phone ?? "")"
            return label
        }
        return factory
    }
    
    var resendCodeInLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("TIMER_PHONE_RESEND")
    }
    
    var codeErrorLabelFactory : Factory<UILabel> {
        return screenProfile.getLabelFactory("ERROR_INVALID_CODE")
    }
    
    var codeErrorTitleLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("ERROR_TITLE")
    }
    
    var codeErrorSubTitleLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("ERROR_SUBTITLE")
    }
    
    var resendButtonFactory: Factory<PrimaryButton> {
        return screenProfile.getPrimaryButtonFactory("BUTTON_CODE_RESEND")
    }
    
    var activityIndicatorFactory : Factory<MDCActivityIndicator> {
        return MDCActivityIndicator.getFactory(color: mainColorProfile.color)
    }
    
    var backgroundColor: UIColor = .clear
}
