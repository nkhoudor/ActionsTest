//
//  EnterCodeView.swift
//  Vivex
//
//  Created by Nik, 6/01/2020
//

import Foundation
import PinLayout
import MaterialComponents.MaterialActivityIndicator

public class EnterCodeView : UIView {
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    var configurator: EnterCodeConfiguratorProtocol!
    
    var numfieldsCount = 6
    var numfields : [NumTextField] = []
    var contentView : UIView!
    var titleLabel : UILabel!
    var subTitleLabel : UILabel!
    var numfieldsView : UIView!
    
    var errorView = UIView.clearView()
    var codeErrorTitleLabel : UILabel!
    var codeErrorSubTitleLabel : UILabel!
    
    var resendView : UIView!
    var resendCodeInLabel : UILabel!
    var resendCodeInText : String!
    var resendButton : UIButton!
    var activityIndicator : MDCActivityIndicator!
    
    private func createView() {
        backgroundColor = configurator.backgroundColor
        contentView = UIView()
        contentView.backgroundColor = .clear
        
        titleLabel  = configurator.titleLabelFactory()
        subTitleLabel = configurator.subtitleLabelFactory()
        
        codeErrorTitleLabel = configurator.codeErrorTitleLabelFactory()
        codeErrorTitleLabel.numberOfLines = 0
        codeErrorTitleLabel.textAlignment = .center
        
        codeErrorSubTitleLabel = configurator.codeErrorSubTitleLabelFactory()
        codeErrorSubTitleLabel.numberOfLines = 0
        codeErrorSubTitleLabel.textAlignment = .center
        
        errorView.alpha = 0.0
        
        resendView = UIView()
        resendView.backgroundColor = .clear
        
        resendCodeInLabel = configurator.resendCodeInLabelFactory()
        resendCodeInLabel.textAlignment = .center
        resendCodeInText = resendCodeInLabel.text ?? ""
        
        resendButton = configurator.resendButtonFactory()
        resendButton.alpha = 0.0
        
        numfieldsView = UIView()
        numfieldsView.backgroundColor = .clear
        
        activityIndicator = configurator.activityIndicatorFactory()
        activityIndicator.alpha = 0.0
        activityIndicator.startAnimating()
        
        addSubview(contentView)
        contentView.addSubview(numfieldsView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        for i in 0...numfieldsCount-1 {
            numfields.append(configurator.numTextFieldFactory())
            numfieldsView.addSubview(numfields[i])
        }
        errorView.addSubview(codeErrorTitleLabel)
        errorView.addSubview(codeErrorSubTitleLabel)
        contentView.addSubview(errorView)
        contentView.addSubview(resendView)
        resendView.addSubview(resendCodeInLabel)
        resendView.addSubview(resendButton)
        addSubview(activityIndicator)
    }
    
    init(configurator: EnterCodeConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateResendInLabel(seconds: Int) {
        resendCodeInLabel.text = "\(resendCodeInText!) \(seconds)"
    }
    
    private func layout(size: CGSize) {
        contentView.pin.all().width(size.width)
        let numWidth : CGFloat = UIScreen.main.bounds.width * 40.0 / 375.0
        let numHeight : CGFloat = numWidth * 52.0 / 40.0
        let spacing : CGFloat = UIScreen.main.bounds.width * 12.0 / 375.0
        
        titleLabel.pin.hCenter().top(UIScreen.main.bounds.height * 0.1).sizeToFit()
        subTitleLabel.pin.below(of: titleLabel, aligned: .center).marginTop(8).sizeToFit()
        
        subTitleLabel.adjustWidth(maxWidth: size.width - 32)
        
        numfieldsView.pin.below(of: subTitleLabel, aligned: .center).marginTop(pixel * 92).width(numWidth * CGFloat(numfieldsCount) + spacing * CGFloat(numfieldsCount - 1)).height(numHeight)
        numfields[0].pin.topLeft().width(numWidth).height(numHeight)
        for i in 1...numfieldsCount-1 {
            numfields[i].pin.after(of: numfields[i-1], aligned: .top).marginLeft(spacing).width(numWidth).height(numHeight)
        }
        
        codeErrorTitleLabel.pin.top().left().right().sizeToFit(.width)
        codeErrorSubTitleLabel.pin.below(of: codeErrorTitleLabel).left().right().sizeToFit(.width)
        errorView.pin.vCenter(to: numfieldsView.edge.vCenter).left(16).right(16).wrapContent(.vertically)
        
        
        resendCodeInLabel.pin.top().horizontally(16).sizeToFit(.width)
        resendButton.pin.center(to: resendCodeInLabel.anchor.center).sizeToFit()
        
        resendView.pin.below(of: numfieldsView).marginTop(32).left().right().wrapContent(.vertically)
        
        activityIndicator.pin.center(to: resendCodeInLabel.anchor.center).sizeToFit()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout(size: frame.size)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        layout(size: size)
        return CGSize(width: contentView.frame.width, height: resendView.frame.maxY)
    }
}

extension UIView {
    func adjustWidth(maxWidth: CGFloat) {
        let width = frame.width
        if width > maxWidth {
            let scale = maxWidth / width
            transform = .init(scaleX: scale, y: scale)
        }
    }
}
