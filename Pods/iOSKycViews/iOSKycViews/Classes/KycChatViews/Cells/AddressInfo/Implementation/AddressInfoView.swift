//
//  AddressInfoView.swift
//  Vivex
//
//  Created by Nik, 23/01/2020
//

import iOSBaseViews
import PinLayout

public class AddressInfoView : UIView {
    lazy var pixel = UIScreen.main.bounds.height / 811
    var configurator: AddressInfoConfiguratorProtocol!
    
    var containerView = UIView.clearView()
    var topLabels : [UILabel] = []
    var mainLabels : [UILabel] = []
    var myAddressButton : UIButton!
    private var shadowLayer : CAShapeLayer!
    
    init(form: TemplateFormConfigProtocol, configurator: AddressInfoConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        containerView.layer.cornerRadius = configurator.containerCornerRadius
        
        for field in form.fields {
            guard field.result != nil, !field.result!.isEmpty else { continue }
            let topLabel = configurator.topLabelFactory()
            topLabel.text = field.title
            let mainLabel = configurator.mainLabelFactory()
            mainLabel.text = field.result
            containerView.addSubview(topLabel)
            containerView.addSubview(mainLabel)
            topLabels.append(topLabel)
            mainLabels.append(mainLabel)
        }
        myAddressButton = configurator.myAddressButtonFactory()
        containerView.addSubview(myAddressButton)
        addSubview(containerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        
        containerView.pin.top(10).left(50).right(pixel * 16)
        
        if topLabels.count > 0 {
            for i in 0...topLabels.count-1 {
                if i == 0 {
                    topLabels[i].pin.left(pixel * 16).top(pixel * 23).sizeToFit()
                } else {
                    topLabels[i].pin.below(of: mainLabels[i-1], aligned: .left).marginTop(12).sizeToFit()
                }
                
                mainLabels[i].pin.below(of: topLabels[i], aligned: .left).marginTop(4).sizeToFit()
            }
            
            if let lastMainLabel = mainLabels.last {
                myAddressButton.pin.below(of: lastMainLabel).marginTop(pixel * 25).left(pixel * 16).right(pixel * 16).height(50)
            }
        }        
        
        containerView.pin.top(10).left(50).right(pixel * 16).wrapContent(padding: PEdgeInsets(top: pixel * 16, left: pixel * 16, bottom: pixel * 25, right: pixel * 16))
        
        if shadowLayer == nil {
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
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        pin.width(size.width)
        layout()
        return CGSize(width: frame.width, height: containerView.frame.maxY + 10)
    }
}
