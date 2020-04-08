//
//  PrivacyPolicyConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 28/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import iOSBaseViews

class PrivacyPolicyConfigurator : PrivacyPolicyConfiguratorProtocol {
    
    let screenProfile: ScreenProfile
    
    init(screenProfile: ScreenProfile) {
        self.screenProfile = screenProfile
    }
    
    var backgroundColor: UIColor = .clear
    
    var privacyTextViewFactory: Factory<UITextView> {
        let factory : Factory<UITextView> = { [weak self] in
            let tv = UITextView()
            let label = self?.screenProfile.getLabelFactory("TEXT")()
            tv.isEditable = false
            tv.isScrollEnabled = false
            tv.dataDetectorTypes = .link
            tv.isUserInteractionEnabled = true
            if let text = label?.text, let font = label?.font, let textColor = label?.textColor {
                tv.attributedText = try? NSAttributedString(HTMLString: text, font: font, textColor: textColor)
                tv.linkTextAttributes = [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor : textColor]
            }
            return tv
        }
        return factory
    }
    
    var confirmButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("CONFIRM_BUTTON")
    }
    
    var denyButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("DENY_BUTTON")
    }
}

extension NSAttributedString {
    public convenience init?(HTMLString html: String, font: UIFont? = nil, textColor: UIColor? = .black) throws {
        let options : [NSAttributedString.DocumentReadingOptionKey : Any] =
            [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]

        guard let data = html.data(using: .utf8, allowLossyConversion: true) else {
            throw NSError(domain: "Parse Error", code: 0, userInfo: nil)
        }

        if let font = font {
            guard let attr = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) else {
                throw NSError(domain: "Parse Error", code: 0, userInfo: nil)
            }
            var attrs = attr.attributes(at: 0, effectiveRange: nil)
            attrs[NSAttributedString.Key.font] = font
            attrs[NSAttributedString.Key.foregroundColor] = textColor
            attr.addAttributes(attrs, range: NSRange(location: 0, length: attr.length))
            self.init(attributedString: attr)
        } else {
            try? self.init(data: data, options: options, documentAttributes: nil)
        }
    }
}
