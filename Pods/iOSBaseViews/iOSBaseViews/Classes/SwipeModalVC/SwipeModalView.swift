//
//  SwipeModalView.swift
//  iOSKyc
//
//  Created by Nik on 19/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import PinLayout

public class SwipeModalView : UIView {
    var presentedView : UIView!
    var arrowImageView = UIImageView()
    var arrowButton = UIButton()
    var configurator : SwipeModalConfiguratorProtocol!
    
    init(presentedView: UIView, configurator: SwipeModalConfiguratorProtocol) {
        super.init(frame: .zero)
        self.presentedView = presentedView
        addSubview(presentedView)
        addSubview(arrowImageView)
        addSubview(arrowButton)
        configurator.arrowImageFactory(arrowImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        presentedView.pin.all()
        arrowImageView.pin.top(pin.safeArea).marginTop(20).hCenter().sizeToFit()
        arrowButton.pin.center(to: arrowImageView.anchor.center).size(arrowImageView.frame.size)
    }
}
