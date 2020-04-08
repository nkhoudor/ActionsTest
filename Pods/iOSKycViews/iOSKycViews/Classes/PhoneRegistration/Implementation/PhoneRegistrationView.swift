//
//  PhoneRegistrationView.swift
//  iOSKycViews
//
//  Created by Nik on 01/01/2020.
//

import UIKit
import PinLayout
import RxSwift
import RxKeyboard
import PhoneNumberKit
import iOSBaseViews

class PhoneRegistrationView : UIView {
    var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    var configurator : PhoneRegistrationConfiguratorProtocol!
    
    let disposeBag = DisposeBag()
    
    lazy var contentView : UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    lazy var logoImageView : UIImageView = {
        let iv = UIImageView()
        configurator.logoImageConfigurationFactory(iv)
        return iv
    }()
    
    lazy var phoneNumberLabel : UILabel = {
        return configurator.phoneNumberLabelFactory()
    }()
    
    lazy var phoneTextField : LimitedLengthTextField = {
        let tf = LimitedLengthTextField()
        tf.keyboardType = .numberPad
        configurator.phoneTextFieldFactory(tf)
        tf.maxLength = configurator.phoneMaxLength
        return tf
    }()
    
    lazy var underLine : UIView = {
        return configurator.underlineFactory()
    }()
    
    lazy var errorLabel : UILabel = {
        return configurator.errorLabelFactory()
    }()
    
    lazy var privacyTextView : UITextView = {
        let tv = configurator.disclaimerFactory()
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.dataDetectorTypes = .link
        let padding = tv.textContainer.lineFragmentPadding
        tv.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        return tv
    }()
    
    lazy var continueButton : PrimaryButton = {
        return configurator.continueButtonFactory()
    }()
    
    init(configurator : PhoneRegistrationConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        backgroundColor = .clear
        addSubview(contentView)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(phoneTextField)
        contentView.addSubview(underLine)
        contentView.addSubview(errorLabel)
        contentView.addSubview(privacyTextView)
        addSubview(continueButton)
        
        errorLabel.alpha = 0
        
        RxKeyboard.instance.visibleHeight.drive(onNext: {[weak self] keyboardVisibleHeight in
            guard keyboardVisibleHeight != self?.keyboardHeight else { return }
            self?.keyboardHeight = keyboardVisibleHeight
            UIView.animate(withDuration: 0.3) {
                self?.layoutSubviews()
            }
        }).disposed(by: disposeBag)
    }
    
    var keyboardHeight : CGFloat = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.pin
            .left()
            .top()
            .right()
            .bottom(keyboardHeight)
        
        logoImageView.pin
            .top(pixel * 92.0)
            .hCenter()
            .sizeToFit()
        
        phoneNumberLabel.pin
            .below(of: logoImageView)
            .marginTop(pixel * 61.0)
            .horizontally(16)
            .sizeToFit(.width)
        phoneTextField.pin
            .below(of: phoneNumberLabel)
            .marginTop(5)
            .horizontally(16)
            .sizeToFit(.width)
        underLine.pin
            .below(of: phoneTextField)
            .marginTop(6)
            //.height(1)
            .horizontally(16)
        errorLabel.pin
            .below(of: underLine)
            .horizontally(16)
            .sizeToFit(.width)
        privacyTextView.pin
            .below(of: errorLabel)
            .marginTop(5)
            .horizontally(16)
            .sizeToFit(.width)
        continueButton.pin
            .bottom(to: contentView.edge.bottom)
            .marginBottom(pixel * 16.0)
            .height(50)
            .horizontally(16)
    }
}
