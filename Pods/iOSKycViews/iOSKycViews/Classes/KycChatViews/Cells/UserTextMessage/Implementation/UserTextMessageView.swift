//
//  UserTextMessageView.swift
//  Vivex
//
//  Created by Nik, 17/01/2020
//

import Foundation
import PinLayout

public class UserTextMessageView : UIView {
    var configurator: UserTextMessageConfiguratorProtocol!
    
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    lazy var verticalMargin = configurator.verticalMargin * pixel
    lazy var horizontalMargin = configurator.horizontalMargin * pixel
    
    private var shadowLayer : CAShapeLayer!
    
    private let containerView = UIView.clearView()
    let messageLabel = UILabel()
    private let padding: CGFloat = 10
    
    init(configurator: UserTextMessageConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        
        messageLabel.textColor = configurator.textColor
        messageLabel.font = configurator.textFont
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        
        addSubview(containerView)
        containerView.addSubview(messageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        messageLabel.pin
            .topRight()
            .width(frame.width - 2 * horizontalMargin)
            .sizeToFit(.widthFlexible)
        
        
        containerView.pin
            .top()
            .right(16 * pixel)
            .marginTop(padding)
            .wrapContent(padding: PEdgeInsets(top: verticalMargin, left: horizontalMargin, bottom: verticalMargin, right: horizontalMargin))
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: containerView.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft], cornerRadii: CGSize(width: configurator.textContainerRadius, height: configurator.textContainerRadius)).cgPath
            shadowLayer.fillColor = configurator.textContainerColor.cgColor

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
