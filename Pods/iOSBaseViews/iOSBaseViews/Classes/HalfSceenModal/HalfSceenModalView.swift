//
//  HalfSceenModalView.swift
//  Vivex
//
//  Created by Nik, 30/01/2020
//

import Foundation
import PinLayout

public class HalfSceenModalView : UIView {
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    var configurator: HalfSceenModalConfiguratorProtocol!
    
    var coverButton = UIButton()
    var containerView = UIView()
    var presentingView: UIView!
    
    var topArrowImageView = UIImageView()
    var titleLabel : UILabel?
    var underline : UIView?
    
    
    init(presentingView: UIView, configurator: HalfSceenModalConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
                
        containerView.backgroundColor = configurator.backgroundColor
        
        self.presentingView = presentingView
        
        coverButton.setTitle(nil, for: .normal)
        addSubview(containerView)
        addSubview(coverButton)
        
        configurator.topArrowImageViewFactory(topArrowImageView)
        
        if configurator.titleLabelFactory != nil {
            titleLabel = configurator.titleLabelFactory!()
            titleLabel!.textAlignment = .center
            containerView.addSubview(titleLabel!)
        }
        
        if configurator.titleUnderlineColor != nil {
            underline = UIView()
            underline!.backgroundColor = configurator.titleUnderlineColor
            containerView.addSubview(underline!)
        } else if configurator.titleUnderlineFactory != nil {
            underline = configurator.titleUnderlineFactory!()
            containerView.addSubview(underline!)
        }
        
        containerView.addSubview(topArrowImageView)
        containerView.addSubview(presentingView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        
        containerView.roundCorners(corners: [.topLeft, .topRight], radius: configurator.cornerRadius)
        containerView.pin.left().right().bottom().height(bounds.height * configurator.coverRatio)
        
        
        topArrowImageView.pin.top(pixel * 18).hCenter().sizeToFit()
        if titleLabel != nil {
            let titleSize = titleLabel!.sizeThatFits(frame.size)
            titleLabel!.pin.top(40 + topArrowImageView.frame.maxY / 2.0 - titleSize.height / 2.0).left().right().sizeToFit(.width)
        }
        
        if configurator.titleUnderlineColor != nil {
            underline?.pin.top(80).left().right().height(1)
        } else if configurator.titleUnderlineFactory != nil {
            underline?.pin.top(80).left().right()
        }
        
        
        var presentingViewHeight : CGFloat = bounds.height * configurator.coverRatio
        
        if underline != nil {
            presentingViewHeight -= 81
        } else if titleLabel != nil {
            presentingViewHeight -= titleLabel!.frame.maxY
        } else {
            presentingViewHeight -= topArrowImageView.frame.maxY
        }
        
        presentingView.pin.below(of: underline ?? titleLabel ?? topArrowImageView).left().right().height(presentingViewHeight)
        
        coverButton.pin.top().left().right().bottom(to: topArrowImageView.edge.top)
    }
}
