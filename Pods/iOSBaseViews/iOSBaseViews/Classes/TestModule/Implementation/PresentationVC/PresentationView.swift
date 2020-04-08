//
//  PresentationView.swift
//  iOSBaseViews_Example
//
//  Created by Nik on 01/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import PinLayout

class PresentationView : UIView {
    private let safeAreaContainerView = UIView()
    private var subView : UIView!
    
    init(subView: UIView) {
        super.init(frame: .zero)
        backgroundColor = .white
        self.subView = subView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(safeAreaContainerView)
        safeAreaContainerView.pin.all(pin.safeArea)
        safeAreaContainerView.addSubview(subView)
        subView.pin.all()
    }
}
