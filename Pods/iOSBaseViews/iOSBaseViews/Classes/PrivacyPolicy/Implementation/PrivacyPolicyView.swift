//
//  PrivacyPolicyView.swift
//  Vivex
//
//  Created by Nik, 28/01/2020
//

import PinLayout

public class PrivacyPolicyView : UIScrollView {
    var configurator: PrivacyPolicyConfiguratorProtocol!
    
    var privacyTextView : UITextView!
    var confirmButton : UIButton!
    var denyButton : UIButton!
    
    lazy var buttonsView = UIView.clearView()
    
    init(configurator: PrivacyPolicyConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        backgroundColor = configurator.backgroundColor
        privacyTextView = configurator.privacyTextViewFactory()
        confirmButton = configurator.confirmButtonFactory()
        denyButton = configurator.denyButtonFactory()
        addSubview(privacyTextView)
        buttonsView.addSubview(confirmButton)
        buttonsView.addSubview(denyButton)
        addSubview(buttonsView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        privacyTextView.pin.top(5).left(16).right(16).sizeToFit(.width)
        
        confirmButton.pin.width(frame.width - 32).height(48)
        denyButton.pin.below(of: confirmButton,aligned: .center).marginTop(16).sizeToFit()
        
        var buttonsMargin : CGFloat = frame.height - privacyTextView.frame.maxY - 48.0 - 50.0 - denyButton.frame.height
        if buttonsMargin < 16.0 {
            buttonsMargin = 16.0
        }
        
        buttonsView.pin.below(of: privacyTextView).marginTop(buttonsMargin).wrapContent(.all, padding: 16)
        contentSize = CGSize(width: frame.width, height: buttonsView.frame.maxY + 16)
        //denyButton.pin.bottom(pin.safeArea).marginBottom(16).hCenter().sizeToFit()
        //confirmButton.pin.above(of: denyButton).marginBottom(16).left(16).right(16).height(48)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return size
    }
}
