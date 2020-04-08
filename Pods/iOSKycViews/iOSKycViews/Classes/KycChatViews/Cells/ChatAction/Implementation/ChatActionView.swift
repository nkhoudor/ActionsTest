//
//  ChatActionView.swift
//  Vivex
//
//  Created by Nik, 17/01/2020
//

import Foundation
import PinLayout

public class ChatActionView : UIView {
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    var configurator: ChatActionConfiguratorProtocol!
    
    var firstButton : UIButton!
    var secondButton : UIButton?
    
    init(configurator: ChatActionConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        
        firstButton = configurator.firstButtonFactory()
        secondButton = configurator.secondButtonFactory?()
        addSubview(firstButton)
        if secondButton != nil {
            addSubview(secondButton!)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        firstButton.pin.top(15).hCenter().sizeToFit()
        secondButton?.pin.below(of: firstButton, aligned: .center).marginTop(pixel * 15).sizeToFit()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        pin.width(size.width)
        layoutSubviews()
        let maxY = secondButton?.frame.maxY ?? firstButton.frame.maxY
        return CGSize(width: frame.width, height: maxY + configurator.bottomMargin)
    }
}
