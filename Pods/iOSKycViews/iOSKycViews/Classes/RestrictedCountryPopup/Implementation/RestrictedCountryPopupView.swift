//
//  RestrictedCountryPopupView.swift
//  Vivex
//
//  Created by Nik, 30/01/2020
//

import Foundation
import PinLayout

public class RestrictedCountryPopupView : UIView {
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    var configurator: RestrictedCountryPopupConfiguratorProtocol!
    
    let infoImageView = UIImageView()
    var descriptionLabel : UILabel!
    var changeNumberButton : UIButton!
    var psTextView : UITextView!
    
    init(configurator: RestrictedCountryPopupConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        backgroundColor = .clear
        configurator.infoImageViewFactory(infoImageView)
        descriptionLabel = configurator.descriptionLabelFactory()
        changeNumberButton = configurator.changeNumberButtonFactory()
        psTextView = configurator.psTextViewFactory()
        
        descriptionLabel.textAlignment = .center
        psTextView.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        
        addSubview(infoImageView)
        addSubview(descriptionLabel)
        addSubview(changeNumberButton)
        addSubview(psTextView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        //62 452
        
        let multiplier : CGFloat = frame.height / 452.0
        
        infoImageView.pin.top(multiplier * 62).hCenter().sizeToFit()
        
        descriptionLabel.pin.below(of: infoImageView).marginTop(multiplier * 16).left(16).right(16).sizeToFit(.width)
        
        changeNumberButton.pin.below(of: descriptionLabel).marginTop(multiplier * 40).left(16).right(16).height(48)
        
        psTextView.pin.bottom(multiplier * 66).left(16).right(16).sizeToFit(.width)
    }
}
