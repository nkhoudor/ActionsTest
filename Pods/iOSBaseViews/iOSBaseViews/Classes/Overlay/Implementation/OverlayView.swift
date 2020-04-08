//
//  OverlayView.swift
//  Vivex
//
//  Created by Nik, 9/01/2020
//

import Foundation
import PinLayout

public class OverlayView : UIView {
    var configurator: OverlayConfiguratorProtocol!
    
    var containerView : UIView!
    
    init(configurator: OverlayConfiguratorProtocol, containerView: UIView) {
        super.init(frame: .zero)
        backgroundColor = .white
        self.configurator = configurator
        self.containerView = containerView
        addSubview(containerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        containerView.pin.all()
    }
}
