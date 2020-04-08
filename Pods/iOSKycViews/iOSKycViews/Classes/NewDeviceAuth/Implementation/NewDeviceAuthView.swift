//
//  NewDeviceAuthView.swift
//  Vivex
//
//  Created by Nik, 8/02/2020
//

import Foundation
import PinLayout

public class NewDeviceAuthView : UIView {
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    var configurator: NewDeviceAuthConfiguratorProtocol!
    
    var title : UILabel!
    var subtitle : UILabel!
    var imageView = UIImageView()
    var confirmButton : UIButton!
    var denyButton : UIButton!
    
    init(configurator: NewDeviceAuthConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        title = configurator.titleFactory()
        title.textAlignment = .center
        subtitle = configurator.subtitleFactory()
        subtitle.textAlignment = .center
        subtitle.numberOfLines = 0
        configurator.deviceImageConfigurationFactory(imageView)
        confirmButton = configurator.confirmButtonFactory()
        denyButton = configurator.denyButtonFactory()
        
        addSubview(title)
        addSubview(subtitle)
        addSubview(imageView)
        addSubview(confirmButton)
        addSubview(denyButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        title.pin.top(pixel * 40).horizontally(16).sizeToFit(.width)
        subtitle.pin.below(of: title).marginTop(pixel * 10).horizontally(16).sizeToFit(.width)
        imageView.pin.below(of: subtitle).marginTop(pixel * 20).hCenter().sizeToFit()
        
        denyButton.pin.bottom(pin.safeArea.bottom + 16).horizontally(16).sizeToFit(.width)
        confirmButton.pin.above(of: denyButton).marginBottom(16).horizontally(16).height(48)
    }
}
