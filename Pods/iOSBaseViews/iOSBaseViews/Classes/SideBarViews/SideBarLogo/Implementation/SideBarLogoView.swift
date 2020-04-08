//
//  SideBarLogoView.swift
//  Vivex
//
//  Created by Nik, 9/01/2020
//

import Foundation
import PinLayout

public class SideBarLogoView : UIView {
    var configurator: SideBarLogoConfiguratorProtocol!
    
    var logoImageView : UIImageView!
    
    private func createView() {
        backgroundColor = configurator.backgroundColor
        logoImageView = UIImageView()
        configurator.logoImageFactory(logoImageView)
        addSubview(logoImageView)
    }
    
    init(configurator: SideBarLogoConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        createView()
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        logoImageView.pin.top().hCenter().sizeToFit()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: logoImageView.image?.size.height ?? 0)
    }
}
