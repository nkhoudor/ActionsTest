//
//  SideBarMaskLogoutView.swift
//  Vivex
//
//  Created by Nik, 9/01/2020
//

import Foundation
import PinLayout

public class SideBarMaskLogoutView : UIView {
    var configurator: SideBarMaskLogoutConfiguratorProtocol!
    
    lazy var pixel : CGFloat = UIScreen.main.bounds.width / 375.0
    lazy var contentViewPadding : CGFloat = 24 * pixel
    lazy var imageViewHeight : CGFloat = 32 * pixel
    var contentView : UIView!
    //var maskImageView : FrameImageView!
    var maskImageView : UIImageView!
    var maskLabel : UILabel!
    var maskSwitch : UISwitch!
    
    var logoutView : UIView!
    var logoutButton : UIButton!
    var logoutImageView : UIImageView?
    var logoutLabel : UILabel?
    
    private func createView() {
        backgroundColor = configurator.backgroundColor
        contentView = UIView()
        contentView.layer.backgroundColor = configurator.contentViewBackgroundColor.cgColor
        contentView.layer.cornerRadius = configurator.contentViewRadius
        
        maskImageView = UIImageView()
        //maskImageView.layer.cornerRadius = configurator.contentViewRadius
        //maskImageView.layer.backgroundColor = configurator.imageBackgroundColor.cgColor
        configurator.maskImageFactory(maskImageView)
        
        maskLabel = configurator.maskLabelFactory()
        maskSwitch = configurator.maskSwitchFactory()
        
        logoutView = UIView.clearView()
        contentView.addSubview(logoutView)
        logoutButton = UIButton()
        logoutButton.setTitle(nil, for: .normal)
        logoutView.addSubview(logoutButton)
        if configurator.logoutImageFactory != nil {
            logoutImageView = UIImageView()
            //logoutImageView!.layer.cornerRadius = configurator.contentViewRadius
            //logoutImageView!.layer.backgroundColor = configurator.imageBackgroundColor.cgColor
            configurator.logoutImageFactory!(logoutImageView!)
            logoutView.addSubview(logoutImageView!)
        }
        
        if configurator.logoutLabelFactory != nil {
            logoutLabel = configurator.logoutLabelFactory!()
            logoutView.addSubview(logoutLabel!)
        }
        
        addSubview(contentView)
        contentView.addSubview(maskImageView)
        contentView.addSubview(maskLabel)
        contentView.addSubview(maskSwitch)
    }
    
    init(configurator: SideBarMaskLogoutConfiguratorProtocol) {
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
        
        maskImageView.pin
            .left(configurator.contentViewMargin)
            .top(contentViewPadding)
            .height(imageViewHeight)
            .aspectRatio(1)
        
        maskLabel.pin
            .right(of: maskImageView, aligned: .center)
            .marginLeft(12 * pixel)
            .sizeToFit()
        
        maskSwitch.pin
            .right(configurator.contentViewMargin)
            .vCenter(to: maskImageView.edge.vCenter)
            .sizeToFit()
        
        let logoutViewHeight : CGFloat = logoutButton != nil || logoutLabel != nil ? imageViewHeight : 0
        
        logoutView.pin.horizontally().below(of: maskImageView).marginTop(28 * pixel).height(logoutViewHeight)
        
        logoutButton.pin.all()
        
        if logoutImageView != nil {
            logoutImageView!.pin
                .top()
                .left(configurator.contentViewMargin)
                .height(imageViewHeight)
                .aspectRatio(1.0)
        }
        
        if logoutLabel != nil {
            if logoutImageView != nil {
                logoutLabel!.pin
                    .right(of: logoutImageView!, aligned: .center)
                    .marginLeft(12 * pixel)
                    .sizeToFit()
            } else {
                logoutLabel!.pin.vCenter().left(to: maskLabel.edge.left).sizeToFit()
            }
        }
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        var height = imageViewHeight + 2 * contentViewPadding
        if configurator.logoutLabelFactory != nil || configurator.logoutImageFactory != nil {
            height += imageViewHeight + 28 * pixel
        }
        return CGSize(width: UIScreen.main.bounds.width, height: height)
    }
}
