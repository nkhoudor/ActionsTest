//
//  PinCodeView.swift
//  iOSBaseViews
//
//  Created by Nik on 04/01/2020
//

import Foundation
import PinLayout

class PinCodeView : UIView {
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    
    var configurator: PinCodeConfiguratorProtocol!
    
    var logoImageView : UIImageView!
    
    var titleLabel : UILabel?
    var subTitleLabel : UILabel?
    var numpadView : UIView!
    var errorLabel : UILabel!
    var numpads : [DigitButton] = []
    var dots : [DotView] = []
    
    var biometricsButton : UIButton?
    var eraseButton : UIButton!
    var forgotButton : UIButton?
    var policyButton : UIButton?
    
    //for layout purposes
    var _topView : UIView!
    
    private func createView() {
        backgroundColor = configurator.backgroundColor
        _topView = UIView.clearView()
        logoImageView = UIImageView()
        configurator.logoImageFactory?(logoImageView)
        titleLabel = configurator.titleLabelFactory?()
        subTitleLabel = configurator.subtitleLabelFactory?()
        if configurator.policyButtonFactory != nil {
            policyButton = UIButton()
            configurator.policyButtonFactory!(policyButton!)
        } else {
            policyButton = nil
        }
        forgotButton = configurator.forgotButtonFactory?()
        eraseButton = UIButton()
        eraseButton.setTitle(nil, for: .normal)
        configurator.eraseButtonImageFactory(eraseButton)
        if configurator.biometricsButtonFactory != nil {
            biometricsButton = UIButton()
            configurator.biometricsButtonFactory!(biometricsButton!)
        } else {
            biometricsButton = nil
        }
        errorLabel = configurator.errorLabelFactory()
        errorLabel.textAlignment = .center
        numpadView = UIView.clearView()
    }
    
    init(configurator: PinCodeConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        createView()
        addSubview(_topView)
        addSubview(numpadView)
        for i in 0...9 {
            numpads.append(configurator.digitButtonFactory())
            numpads[i].setTitle("\(i)", for: .normal)
            numpadView.addSubview(numpads[i])
        }
        addSubview(eraseButton)
        for i in 0...3 {
            dots.append(configurator.dotFactory())
            addSubview(dots[i])
        }
        addSubview(errorLabel)
        errorLabel.alpha = 0.0
        addSubview(logoImageView)
        if titleLabel != nil {
            addSubview(titleLabel!)
        }
        if subTitleLabel != nil {
            addSubview(subTitleLabel!)
        }
        if policyButton != nil {
            addSubview(policyButton!)
        }
        if biometricsButton != nil {
            addSubview(biometricsButton!)
        }
        if forgotButton != nil {
            addSubview(forgotButton!)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let padWidth : CGFloat = 72.0 * pixel
        let spacing : CGFloat = 24.0 * pixel
        numpadView.backgroundColor = .clear
        numpadView.pin.left().right().top(237.0 * pixel).height(4 * padWidth + 3 * spacing)
        numpads[2].pin.hCenter().width(padWidth).aspectRatio(1.0).top()
        numpads[1].pin.left(of: numpads[2], aligned: .top).marginRight(spacing).width(padWidth).aspectRatio(1.0)
        numpads[3].pin.right(of: numpads[2], aligned: .top).marginLeft(spacing).width(padWidth).aspectRatio(1.0)
        numpads[5].pin.below(of: numpads[2], aligned: .left).marginTop(spacing) .width(padWidth).aspectRatio(1.0)
        numpads[4].pin.left(of: numpads[5], aligned: .top).marginRight(spacing).width(padWidth).aspectRatio(1.0)
        numpads[6].pin.right(of: numpads[5], aligned: .top).marginLeft(spacing).width(padWidth).aspectRatio(1.0)
        numpads[8].pin.below(of: numpads[5], aligned: .left).marginTop(spacing) .width(padWidth).aspectRatio(1.0)
        numpads[7].pin.left(of: numpads[8], aligned: .top).marginRight(spacing).width(padWidth).aspectRatio(1.0)
        numpads[9].pin.right(of: numpads[8], aligned: .top).marginLeft(spacing).width(padWidth).aspectRatio(1.0)
        numpads[0].pin.below(of: numpads[8], aligned: .left).marginTop(spacing) .width(padWidth).aspectRatio(1.0)
        eraseButton.pin.right(of: numpads[0], aligned: .top).marginLeft(spacing).width(padWidth).aspectRatio(1.0)
        biometricsButton?.pin.left(of: numpads[0], aligned: .top).marginRight(spacing).width(padWidth).aspectRatio(1.0)
        
        let dotsSpacing : CGFloat = 16.0 * pixel
        let dotSize : CGFloat = 12.0 * pixel
        dots[1].pin.width(dotSize).aspectRatio(1.0).above(of: numpadView, aligned: .center).marginBottom(4 * dotsSpacing).marginRight(dotSize / 2 + dotsSpacing / 2)
        dots[0].pin.width(dotSize).aspectRatio(1.0).left(of: dots[1], aligned: .top).marginRight(dotsSpacing)
        dots[2].pin.width(dotSize).aspectRatio(1.0).right(of: dots[1], aligned: .top).marginLeft(dotsSpacing)
        dots[3].pin.width(dotSize).aspectRatio(1.0).right(of: dots[2], aligned: .top).marginLeft(dotsSpacing)
        
        _topView.pin.bottom(to: dots[1].edge.top).top(0).hCenter().width(100%)
        
        logoImageView.pin.hCenter().vCenter(to: _topView.edge.vCenter).sizeToFit()
        
        titleLabel?.pin.bottom(to: _topView.edge.vCenter).marginBottom(4).hCenter().sizeToFit()
        subTitleLabel?.pin.top(to: _topView.edge.vCenter).marginTop(4).hCenter().sizeToFit()
        
        errorLabel.pin.below(of: dots[1]).marginTop(10).horizontally(16).sizeToFit(.width)
        
        policyButton?.pin.below(of: numpadView).marginTop(60 * pixel).horizontally(16).sizeToFit(.width)
        forgotButton?.pin.hCenter().below(of: numpadView).marginTop(45 * pixel).sizeToFit()
    }
}
