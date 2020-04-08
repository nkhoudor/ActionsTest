//
//  LabeledTextFieldView.swift
//  iOSKyc
//
//  Created by Nik on 23/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import PinLayout

public protocol ValidatorProtocol: class {
    func isValid(_ value: String?) -> Bool
    func isValid() -> Bool
}

public class LabeledTextFieldView : UIView {
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    
    public var label : UILabel!
    public var textField : LimitedLengthTextField!
    public var underline : UIView!
    
    var labelDefaultColor : UIColor!
    var labelErrorColor : UIColor!
    
    var clickableArea = UIButton()
    
    public weak var validator : ValidatorProtocol?
    
    public func setMaxLength(_ maxLength : Int) {
        textField.maxLength = maxLength
    }
    
    init(labelFactory : Factory<UILabel>, textFieldColor : UIColor, errorColor : UIColor, underlineColor : UIColor) {
        super.init(frame: .zero)
        
        label = labelFactory()
        labelDefaultColor = label.textColor
        labelErrorColor = errorColor
        
        textField = LimitedLengthTextField()
        textField.font = label.font
        textField.textColor = textFieldColor
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldDidEnd(_:)), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(textFieldDidBegin(_:)), for: .editingDidBegin)
        
        underline = UIView()
        underline.backgroundColor = underlineColor
        
        addSubview(textField)
        addSubview(label)
        addSubview(underline)
        
        clickableArea.setTitle(nil, for: .normal)
        clickableArea.addTarget(self, action: #selector(clickableAreaPressed), for: .touchUpInside)
        addSubview(clickableArea)
    }
    
    @objc func clickableAreaPressed() {
        textField.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func textFieldDidBegin(_ textField: UITextField) {
        updateLabelState(minimized: true)
        clickableArea.alpha = 0.0
    }
    
    @objc public func textFieldDidEnd(_ textField: UITextField) {
        updateLabelState(minimized: textField.text?.count ?? 0 != 0)
        textFieldDidChange(textField)
        clickableArea.alpha = 1.0
    }
    
    public func getTextValue() -> String {
        if let text = textField.text, !text.isEmpty {
            return text
        } else {
            textFieldDidChange(textField)
            return ""
        }
    }
    
    @objc public func textFieldDidChange(_ textField: UITextField) {
        if validator != nil {
            updateLabelColor(isValid: validator!.isValid(textField.text))
        } else {
            let textEmpty : Bool = (textField.text?.count ?? 0) == 0
            updateLabelColor(isValid: !textEmpty)
        }
    }
    
    private func updateLabelColor(isValid: Bool) {
        let color = isValid ? labelDefaultColor : labelErrorColor
        UIView.transition(with: label, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.label.textColor = color
        }, completion: nil)
    }
    
    private func updateLabelState(minimized: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let label = self?.label else { return }
            if minimized {
                let transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
                self?.label.transform = transform.translatedBy(x: -label.frame.width / 6.0, y: -32.0)
            } else {
                self?.label.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        textField.pin.top(pixel * 44).horizontally().sizeToFit(.width)
        label.pin.vCenter(to: textField.edge.vCenter).left().sizeToFit()
        underline.pin.below(of: textField).marginTop(2).left().right().height(1)
        clickableArea.pin.all()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        pin.width(size.width)
        layoutSubviews()
        let maxY = underline.frame.maxY
        return CGSize(width: frame.width, height: maxY)
    }
}

public extension LabeledTextFieldView {
    static func getFactory(labelFactory : @escaping Factory<UILabel>, textFieldColor : UIColor, errorColor : UIColor, underlineColor : UIColor) -> Factory<LabeledTextFieldView> {
        let factory = { () -> LabeledTextFieldView in
            let res = LabeledTextFieldView(labelFactory: labelFactory, textFieldColor: textFieldColor, errorColor: errorColor, underlineColor: underlineColor)
            return res
        }
        return factory
    }
}
