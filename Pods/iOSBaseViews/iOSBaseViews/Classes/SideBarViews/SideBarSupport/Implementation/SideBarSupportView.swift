//
//  SideBarSupportView.swift
//  Vivex
//
//  Created by Nik, 9/01/2020
//

import Foundation
import PinLayout

public class SideBarSupportView : UIView {
    var configurator: SideBarSupportConfiguratorProtocol!
    
    lazy var pixel : CGFloat = UIScreen.main.bounds.width / 375.0
    lazy var contentViewPadding : CGFloat = 24 * pixel
    lazy var imageViewHeight : CGFloat = 32 * pixel
    var contentView : UIView!
    
    var supportButton : UIButton!
    var supportImageView : UIImageView!
    var supportLabel : UILabel!
    
    private func createView() {
        backgroundColor = configurator.backgroundColor
        contentView = UIView()
        contentView.layer.backgroundColor = configurator.contentViewBackgroundColor.cgColor
        contentView.layer.cornerRadius = configurator.contentViewRadius
        
        supportButton = UIButton()
        supportButton.setTitle(nil, for: .normal)
        contentView.addSubview(supportButton)
        
        supportImageView = UIImageView()
        configurator.supportImageFactory(supportImageView)
        contentView.addSubview(supportImageView)
        
        supportLabel = configurator.supportLabelFactory()
        contentView.addSubview(supportLabel)
        
        addSubview(contentView)
    }
    
    init(configurator: SideBarSupportConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        contentView.pin
            .top()
            .bottom()
            .horizontally(configurator.contentViewMargin)
        
        supportButton.pin.all()
        
        supportImageView.pin
            .top(contentViewPadding)
            .left(configurator.contentViewMargin)
            .height(imageViewHeight)
            .aspectRatio(1.0)
            
        supportLabel.pin
            .right(of: supportImageView, aligned: .center)
            .marginLeft(12 * pixel)
            .sizeToFit()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: imageViewHeight + 2 * contentViewPadding)
    }
}
