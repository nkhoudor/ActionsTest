//
//  BotLoadingMessageView.swift
//  Vivex
//
//  Created by Nik, 21/01/2020
//

import PinLayout
import MaterialComponents.MaterialActivityIndicator

public class BotLoadingMessageView : UIView {
    var configurator: BotLoadingMessageConfiguratorProtocol!
    
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    lazy var verticalMargin = configurator.verticalMargin * pixel
    lazy var horizontalMargin = configurator.horizontalMargin * pixel
    lazy var avatarMargin = configurator.avatarMargin * pixel

    var activityIndicator : MDCActivityIndicator!
    private let containerView = UIView()
    let botAvatarImageView = UIImageView()
    private let padding: CGFloat = 10
    
    init(configurator: BotLoadingMessageConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        activityIndicator = configurator.activityIndicatorFactory()
        activityIndicator.startAnimating()
        
        containerView.backgroundColor = configurator.containerBackgroundColor
        
        configurator.botAvatarImageFactory(botAvatarImageView)
        botAvatarImageView.alpha = 0.0
        
        addSubview(containerView)
        addSubview(botAvatarImageView)
        containerView.addSubview(activityIndicator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        
        containerView.roundCorners(corners: [.topLeft, .topRight, .bottomRight], radius: configurator.containerRadius)
        
        botAvatarImageView.pin
            .left(avatarMargin)
            .bottom(verticalMargin)
            .sizeToFit()
        
        activityIndicator.sizeToFit()
        
        containerView.pin
            .top()
            .left(botAvatarImageView.frame.size.width + 1.5 * avatarMargin)
            .marginTop(padding)
            .wrapContent(padding: PEdgeInsets(top: verticalMargin, left: horizontalMargin, bottom: verticalMargin, right: horizontalMargin))
    }
    
    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        pin.width(size.width)
        layout()
        return CGSize(width: frame.width, height: containerView.frame.maxY + 10)
    }
}
