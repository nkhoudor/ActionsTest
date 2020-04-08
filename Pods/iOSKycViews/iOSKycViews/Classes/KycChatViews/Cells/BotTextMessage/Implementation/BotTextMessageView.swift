//
//  BotTextMessageView.swift
//  Vivex
//
//  Created by Nik, 16/01/2020
//

import Foundation
import PinLayout
import iOSBaseViews

public class BotTextMessageView : UIView {
    var configurator: BotTextMessageConfiguratorProtocol!
    
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    lazy var verticalMargin = configurator.verticalMargin * pixel
    lazy var horizontalMargin = configurator.horizontalMargin * pixel
    lazy var avatarMargin = configurator.avatarMargin * pixel

    private let containerView = UIView()
    let messageLabel = UILabel()
    let botAvatarImageView = UIImageView()
    private let padding: CGFloat = 10

    private let imagesContainerView = UIView.clearView()
    let showImagesButton = UIButton()
    
    var imageViews : [MaskImageView] = []
    
    private var warningVisible : Bool = false
    let warningView = UIView()
    
    init(configurator: BotTextMessageConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        
        containerView.backgroundColor = configurator.textBackgroundColor
        
        messageLabel.textColor = configurator.textColor
        messageLabel.font = configurator.textFont
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        
        configurator.botAvatarImageFactory(botAvatarImageView)
        botAvatarImageView.alpha = 0.0
        
        addSubview(containerView)
        containerView.addSubview(messageLabel)
        
        addSubview(botAvatarImageView)
        containerView.addSubview(imagesContainerView)
        imagesContainerView.addSubview(showImagesButton)
        
        warningView.backgroundColor = configurator.warningColor
        warningView.layer.cornerRadius = configurator.warningCornerRadius
        addSubview(warningView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateImages(_ images: [ConfigurationFactory<UIImageView>]) {
        imageViews.forEach({ $0.removeFromSuperview() })
        for (i, imageFactory) in images.enumerated() {
            if i == 3 {
                imageViews.last?.updateState(.mask(text: "+\(images.count - 3)"))
                break
            }
            if let miv = configurator.maskImageViewFactory?() {
                imageFactory(miv)
                imagesContainerView.addSubview(miv)
                imageViews.append(miv)
            }
        }
        layoutIfNeeded()
    }
    
    public func update(warningVisible: Bool) {
        self.warningVisible = warningVisible
        layoutSubviews()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        
        containerView.roundCorners(corners: [.topLeft, .topRight, .bottomRight], radius: configurator.textContainerRadius)
        
        botAvatarImageView.pin
            .left(avatarMargin)
            .bottom(verticalMargin)
            .sizeToFit()
        
        var messageLabelMaxWidth : CGFloat = UIScreen.main.bounds.width - 2 * horizontalMargin - 2.5 * avatarMargin - botAvatarImageView.frame.size.width
        
        if warningVisible {
            messageLabelMaxWidth -= horizontalMargin + configurator.warningWidth
        }
        
        messageLabel.pin
            .topLeft()
            .width(messageLabelMaxWidth)
            .sizeToFit(.widthFlexible)
        
        if imageViews.count == 0 {
            imagesContainerView.pin.below(of: messageLabel, aligned: .left).size(CGSize(width: 0, height: 0))
        } else {
            for (i, miv) in imageViews.enumerated() {
                if i == 0 {
                    miv.pin
                        .topLeft()
                        .width(pixel * 60)
                        .height(pixel * 60)
                } else {
                    miv.pin
                        .right(of: imageViews[i-1], aligned: .top)
                        .marginLeft(horizontalMargin / 2)
                        .width(pixel * 60)
                        .height(pixel * 60)
                }
            }
            imagesContainerView.pin.below(of: messageLabel, aligned: .left).marginTop(verticalMargin).wrapContent()
        }
        
        showImagesButton.pin.all()
        
        containerView.pin
            .top()
            .left(botAvatarImageView.frame.size.width + 1.5 * avatarMargin)
            .marginTop(padding)
            .wrapContent(padding: PEdgeInsets(top: verticalMargin, left: warningVisible ? horizontalMargin * 2.0 + configurator.warningWidth : horizontalMargin, bottom: verticalMargin, right: horizontalMargin))
        
        if warningVisible {
            warningView.pin.left(of: messageLabel, aligned: .top).marginRight(horizontalMargin).width(configurator.warningWidth).height(messageLabel.frame.height)
        } else {
            warningView.pin.topLeft().size(CGSize.zero)
        }
    }
    
    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        pin.width(size.width)
        layout()
        return CGSize(width: frame.width, height: containerView.frame.maxY + padding)
    }
}
