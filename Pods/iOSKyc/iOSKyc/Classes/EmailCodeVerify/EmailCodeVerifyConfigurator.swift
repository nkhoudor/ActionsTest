//
//  EmailCodeVerifyConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 04/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation

import iOSKycViews
import iOSBaseViews
import MaterialComponents.MaterialActivityIndicator
import Swinject

class EmailCodeVerifyConfigurator : EnterCodeConfiguratorProtocol {
    
    var viewModel : ConnectEmailViewModel!
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var screenProfile: ScreenProfile = {
        return resolver.resolve(ScreenProfile.self, name: "EMAIL_CONFIRMATION")!
    }()
    
    lazy var mainColorProfile: ColorProfile = {
        return resolver.resolve(ColorProfile.self, name: "primaryButton")!
    }()
    
    lazy var numTextFieldStyleProfile: NumTextFieldStyleProfile = {
        return resolver.resolve(NumTextFieldStyleProfile.self, name: "basicNumTextField")!
    }()
    
    init(viewModel : ConnectEmailViewModel) {
        self.viewModel = viewModel
    }
    
    var numTextFieldFactory: Factory<NumTextField> {
        return numTextFieldStyleProfile.factory
    }
    
    var titleLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("HEADER")
    }
    
    var subtitleLabelFactory: Factory<UILabel> {
        let email = viewModel.email
        let factory : Factory<UILabel> = { [weak self] in
            if email.isEmpty {
                return self?.screenProfile.getLabelFactory("EMPTY_SEND_TO")() ?? UILabel()
            } else {
                guard let label = self?.screenProfile.getLabelFactory("SEND_TO")() else { return UILabel() }
                label.text = "\(label.text ?? "")\(self?.viewModel.email ?? "")"
                return label
            }
            
        }
        return factory
    }
    
    var resendCodeInLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("TIMER_PHONE_RESEND")
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
