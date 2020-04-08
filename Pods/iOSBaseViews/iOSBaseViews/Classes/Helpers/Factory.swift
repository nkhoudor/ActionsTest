//
//  Factory.swift
//  iOSBaseViews
//
//  Created by Nik on 06/01/2020.
//

import Foundation
import MaterialComponents.MaterialActivityIndicator

public extension UILabel {
    static func getFactory(font: UIFont, textColor: UIColor, text: String?) -> Factory<UILabel> {
        let factory = { () -> UILabel in
            let label = UILabel()
            label.font = font
            label.text = text
            label.textColor = textColor
            return label
        }
        return factory
    }
}

public extension UITextField {
    static func getFactory(font: UIFont, textColor: UIColor, text: String?) -> Factory<UITextField> {
        let factory = { () -> UITextField in
            let textField = UITextField()
            textField.font = font
            textField.text = text
            textField.textColor = textColor
            return textField
        }
        return factory
    }
    
    static func getConfigurationFactory(font: UIFont, textColor: UIColor, text: String?) -> ConfigurationFactory<UITextField> {
        return { textField in
            textField.font = font
            textField.text = text
            textField.textColor = textColor
        }
    }
}

public extension UIButton {
    static func getFactory(font: UIFont, textColor: UIColor, text: String? = nil, backgroundColor: UIColor? = nil, cornerRadius: CGFloat = 0) -> Factory<UIButton> {
        let factory = { () -> UIButton in
            let button = UIButton()
            button.setTitle(text, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = font
            button.layer.cornerRadius = cornerRadius
            button.layer.backgroundColor = backgroundColor?.cgColor
            return button
        }
        return factory
    }
}

public extension UISwitch {
    static func getFactory(onColor: UIColor, offColor: UIColor) -> Factory<UISwitch> {
        let factory = { () -> UISwitch in
            let sw = UISwitch()
            sw.onTintColor = onColor
            sw.tintColor = offColor
            return sw
        }
        return factory
    }
}

public extension MDCActivityIndicator {
    static func getFactory(color: UIColor) -> Factory<MDCActivityIndicator> {
        let factory = { () -> MDCActivityIndicator in
            let activityIndicator = MDCActivityIndicator()
            activityIndicator.cycleColors = [color]
            return activityIndicator
        }
        return factory
    }
}
