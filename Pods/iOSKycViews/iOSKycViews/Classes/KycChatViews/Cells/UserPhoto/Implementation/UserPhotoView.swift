//
//  UserPhotoView.swift
//  Vivex
//
//  Created by Nik, 19/01/2020
//

import Foundation
import PinLayout

public class UserPhotoView : UIView {
    lazy var pixel = UIScreen.main.bounds.height / 811
    
    var configurator: UserPhotoConfiguratorProtocol!
    
    lazy var padding = configurator.photoPadding * pixel
    
    private var shadowLayer : CAShapeLayer!
    
    private let containerView = UIView.clearView()
    let photoImageView = UIImageView()
    let clickableArea = UIButton()
        
    init(configurator: UserPhotoConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        addSubview(containerView)
        containerView.addSubview(photoImageView)
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.cornerRadius = configurator.containerRadius
        photoImageView.clipsToBounds = true
        
        clickableArea.setTitle(nil, for: .normal)
        containerView.addSubview(clickableArea)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    public func update(message: UserPhotoMessageEntityProtocol) {
        photoImageView.image = message.image
    }
    
    private func layout() {
        
        photoImageView.pin
            .width(pixel * 143)
            .aspectRatio(1.0)
        
        clickableArea.frame = photoImageView.frame
        
        containerView.pin
            .top()
            .right(16 * pixel)
            .marginTop(padding)
            .wrapContent(padding: padding)
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: containerView.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft], cornerRadii: CGSize(width: configurator.containerRadius, height: configurator.containerRadius)).cgPath
            shadowLayer.fillColor = configurator.containerColor.cgColor

            shadowLayer.shadowColor = configurator.containerShadowColor.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 7.0)
            shadowLayer.shadowOpacity = 0.4
            shadowLayer.shadowRadius = 7

            containerView.layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        pin.width(size.width)
        layout()
        return CGSize(width: frame.width, height: containerView.frame.maxY + padding)
    }
}
