//
//  DevicesListView.swift
//  Vivex
//
//  Created by Nik, 26/01/2020
//

import Foundation
import PinLayout

public class DevicesListView : UIView {
    lazy var pixel = UIScreen.main.bounds.height / 811
    var configurator: DevicesListConfiguratorProtocol!
    
    var titleLabel : UILabel!
    let tableView = UITableView()
    var sendButton = UIButton()
    var recoverButton : UIButton!
    
    var sendLabel : UILabel!
    var resendLabel : UILabel!
    var resendInLabel : UILabel!
    
    var sendButtonShadowLayer : CAShapeLayer!
    var sendButtonProhibitedLayer : CAShapeLayer!
    
    init(configurator: DevicesListConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        tableView.register(DeviceListCell.self, forCellReuseIdentifier: DeviceListCell.reuseIdentifier)
        titleLabel = configurator.titleLabelFactory()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        sendLabel = configurator.sendLabelFactory()
        resendLabel = configurator.resendLabelFactory()
        resendInLabel = configurator.resendInLabelFactory()
        resendInLabel.textAlignment = .center
        
        resendInLabel.alpha = 0.0
        resendLabel.alpha = 0.0
                
        recoverButton = configurator.recoverButtonFactory()
        addSubview(titleLabel)
        addSubview(tableView)
        addSubview(sendButton)
        addSubview(recoverButton)
        addSubview(sendLabel)
        addSubview(resendLabel)
        addSubview(resendInLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.pin.top(pixel * 72).left(16).right(16).sizeToFit(.width)
        
        var cellsCount = tableView.numberOfRows(inSection: 0)
        if cellsCount > 4 {
            cellsCount = 4
        }
        let tableHeight : CGFloat = pixel * 76.0 * CGFloat(cellsCount)
        
        tableView.pin.below(of: titleLabel).marginTop(pixel * 25).left().right().height(tableHeight)
        
        sendButton.pin.below(of: tableView).marginTop(pixel * 35).left(16).right(16).height(48)
        recoverButton.pin.below(of: sendButton).hCenter().marginTop(pixel * 24).sizeToFit()
        
        sendLabel.pin.center(to: sendButton.anchor.center).sizeToFit()
        resendLabel.pin.center(to: sendButton.anchor.center).sizeToFit()
        resendInLabel.pin.center(to: sendButton.anchor.center).size(sendButton.frame.size)
        
        if sendButtonShadowLayer == nil {
            sendButtonShadowLayer = CAShapeLayer()
            sendButtonShadowLayer.path = UIBezierPath(roundedRect: sendButton.bounds, cornerRadius: configurator.sendButtonCornerRadius).cgPath
            sendButtonShadowLayer.fillColor = configurator.sendButtonBackgroundColor.cgColor

            sendButtonShadowLayer.shadowColor = configurator.sendButtonShadowColor.cgColor
            sendButtonShadowLayer.shadowPath = sendButtonShadowLayer.path
            sendButtonShadowLayer.shadowOffset = CGSize(width: 0, height: 7.0)
            sendButtonShadowLayer.shadowOpacity = 0.4
            sendButtonShadowLayer.shadowRadius = 7

            sendButton.layer.insertSublayer(sendButtonShadowLayer, at: 0)
        } else {
            sendButtonShadowLayer.path = UIBezierPath(roundedRect: sendButton.bounds, cornerRadius: configurator.sendButtonCornerRadius).cgPath
            sendButtonShadowLayer.shadowPath = sendButtonShadowLayer.path
        }
        
        if sendButtonProhibitedLayer == nil {
            sendButtonProhibitedLayer = CAShapeLayer()
            sendButtonProhibitedLayer.path = UIBezierPath(roundedRect: sendButton.bounds, cornerRadius: configurator.sendButtonCornerRadius).cgPath
            sendButtonProhibitedLayer.fillColor = configurator.sendButtonProhibitedColor.cgColor
            sendButton.layer.insertSublayer(sendButtonProhibitedLayer, above: sendButtonShadowLayer)
        } else {
            sendButtonProhibitedLayer.path = UIBezierPath(roundedRect: sendButton.bounds, cornerRadius: configurator.sendButtonCornerRadius).cgPath
        }
        
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return size
    }
}
