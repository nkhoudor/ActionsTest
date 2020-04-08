//
//  EnterCodeConfiguratorProtocol.swift
//
//  Created by Nik, 6/01/2020
//

import Foundation
import MaterialComponents.MaterialActivityIndicator

public protocol EnterCodeConfiguratorProtocol {
    
    var numTextFieldFactory : Factory<NumTextField> { get }
    
    var titleLabelFactory : Factory<UILabel> { get }
    var subtitleLabelFactory : Factory<UILabel> { get }
    
    var codeErrorTitleLabelFactory : Factory<UILabel> { get }
    var codeErrorSubTitleLabelFactory : Factory<UILabel> { get }
    
    var resendCodeInLabelFactory : Factory<UILabel> { get }
    var resendButtonFactory : Factory<PrimaryButton> { get }
    
    var activityIndicatorFactory : Factory<MDCActivityIndicator> { get }
    
    var backgroundColor : UIColor { get }
}
