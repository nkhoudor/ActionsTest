//
//  ErrorWarningInfoView.swift
//  Vivex
//
//  Created by Nik, 11/02/2020
//

import Foundation
import PinLayout

public class ErrorWarningInfoView : UIView {
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811
    var configurator: ErrorWarningInfoConfiguratorProtocol!
    
    var title : UILabel!
    var subtitle : UILabel?
    var imageView : UIImageView?
    var bottomTextView : UITextView?
    
    init(configurator: ErrorWarningInfoConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        
        backgroundColor = configurator.backgroundColor
        
        title = configurator.titleFactory()
        title.textAlignment = .center
        title.numberOfLines = 0
        addSubview(title)
        
        if configurator.subtitleFactory != nil {
            subtitle = configurator.subtitleFactory!()
            subtitle!.textAlignment = .center
            subtitle!.numberOfLines = 0
            addSubview(subtitle!)
        }
        
        if configurator.imageConfigurationFactory != nil {
            imageView = UIImageView()
            configurator.imageConfigurationFactory!(imageView!)
            addSubview(imageView!)
        }
        
        if configurator.bottomTextViewFactory != nil {
            bottomTextView = configurator.bottomTextViewFactory!()
            bottomTextView!.textAlignment = .center
            addSubview(bottomTextView!)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let titleTop : CGFloat = CGFloat(292) * frame.height / 728.0
        
        title.pin.top(titleTop).horizontally(16).sizeToFit(.width)
        subtitle?.pin.below(of: title).marginTop(12).horizontally(16).sizeToFit(.width)
        
        imageView?.pin.above(of: title).marginBottom(16).hCenter().sizeToFit()
        
        bottomTextView?.pin.bottom(pixel * 66).horizontally(16).sizeToFit(.width)
    }
}
