//
//  CongratulationsView.swift
//  Vivex
//
//  Created by Nik, 23/01/2020
//

import Foundation
import PinLayout
import RxCocoa

public class CongratulationsView : UIView {
    lazy var pixel = UIScreen.main.bounds.height / 811
    var configurator: CongratulationsConfiguratorProtocol!
    
    var containerView = UIView.clearView()
    var successImageView = UIImageView()
    var titleLabel : UILabel!
    var descriptionLabel : UILabel!
    var whatsNextButton : UIButton?
    private var shadowLayer : CAShapeLayer!
    
    init(configurator: CongratulationsConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        titleLabel = configurator.titleLabelFactory()
        descriptionLabel = configurator.descriptionLabelFactory()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textAlignment = .center
        
        configurator.successImageConfigurationFactory(successImageView)
        
        addSubview(containerView)
        containerView.addSubview(successImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        
        if configurator.whatsNextButtonFactory != nil {
            whatsNextButton = configurator.whatsNextButtonFactory!()
            containerView.addSubview(whatsNextButton!)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        //containerView.pin.top(10).left(50).right(pixel * 16)
        
        successImageView.pin.hCenter().size(CGSize(width: 48, height: 48))
        
        titleLabel.pin.below(of: successImageView, aligned: .center).marginTop(pixel * 12).sizeToFit()
        descriptionLabel.pin.below(of: titleLabel).marginTop(pixel * 12).hCenter().width(bounds.width - 50 - pixel * 16 * 3).sizeToFit(.width)
        
        whatsNextButton?.pin.below(of: descriptionLabel, aligned: .center).marginTop(pixel * 24).width(bounds.width - 50 - pixel * 16 * 3).height(50)
        
        containerView.pin.top(10).left(50).wrapContent(padding: PEdgeInsets(top: pixel * 26, left: pixel * 16, bottom: pixel * 25, right: pixel * 16))
        
        if shadowLayer != nil {
            shadowLayer.removeFromSuperlayer()
        }
        
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: containerView.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: configurator.containerCornerRadius, height: configurator.containerCornerRadius)).cgPath
            shadowLayer.fillColor = configurator.containerBackgroundColor.cgColor
            shadowLayer.shadowColor = configurator.shadowColor.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 7.0)
            shadowLayer.shadowOpacity = 0.4
            shadowLayer.shadowRadius = 7

            containerView.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        pin.width(size.width)
        layout()
        return CGSize(width: frame.width, height: containerView.frame.maxY + 10)
    }
}
