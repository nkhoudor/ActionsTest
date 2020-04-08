//
//  PrivacyPolicyConfiguratorProtocol.swift
//
//  Created by Nik, 28/01/2020
//

public protocol PrivacyPolicyConfiguratorProtocol {
    var backgroundColor : UIColor { get }
    var privacyTextViewFactory : Factory<UITextView> { get }
    var confirmButtonFactory : Factory<UIButton> { get }
    var denyButtonFactory : Factory<UIButton> { get }
}
