//
//  LimitedLengthTextField.swift
//  iOSBaseViews
//
//  Created by Admin on 18/03/2020.
//

import UIKit

public class LimitedLengthTextField: UITextField {
    public var maxLength: Int = 0
    
    class func copy(textField: UITextField) -> LimitedLengthTextField {
        let tf = LimitedLengthTextField()
        tf.textColor = textField.textColor
        tf.font = textField.font
        tf.text = textField.text
        return tf
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        editingChanged()
    }
    
    @objc func editingChanged() {
        if maxLength > 0 {
            let selectedRange = selectedTextRange
            text = String(text!.prefix(maxLength))
            if let selectedRange = selectedRange {
                selectedTextRange = selectedRange
            }
        }
    }
}
