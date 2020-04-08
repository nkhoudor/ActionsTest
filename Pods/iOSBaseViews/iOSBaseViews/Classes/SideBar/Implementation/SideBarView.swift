//
//  SideBarView.swift
//  Vivex
//
//  Created by Nik, 8/01/2020
//

import Foundation
import PinLayout

public class SideBarView : UIView {
    var configurator: SideBarConfiguratorProtocol!
    
    init(configurator: SideBarConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
}
