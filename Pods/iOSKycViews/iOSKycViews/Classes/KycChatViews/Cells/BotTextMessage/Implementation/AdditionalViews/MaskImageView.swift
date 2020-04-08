//
//  MaskImageView.swift
//  iOSKyc
//
//  Created by Nik on 21/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import RxSwift
import RxRelay

public enum MaskImageViewState {
    case normal
    case mask(text: String)
}

public class MaskImageView : UIImageView {
    
    var maskColor : UIColor!
    var maskLabel = UILabel()
    var cornerRadius : CGFloat!
    var maskLayer : CAShapeLayer?
    
    init() {
        super.init(frame: .zero)
        maskLayer = CAShapeLayer()
        layer.insertSublayer(maskLayer!, at: 0)
        addSubview(maskLabel)
        contentMode = .scaleAspectFill
        clipsToBounds = true
        updateState(.normal)
    }
    
    func updateState(_ state: MaskImageViewState) {
        switch state {
        case .normal:
            maskLayer?.isHidden = true
            maskLabel.alpha = 0.0
        case .mask(let text):
            maskLayer?.isHidden = false
            maskLabel.alpha = 1.0
            maskLabel.text = text
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        maskLayer!.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height), cornerRadius: cornerRadius).cgPath
        maskLayer!.fillColor = maskColor.cgColor
        
        maskLabel.pin.center().sizeToFit()
    }
}

public extension MaskImageView {
    static func getFactory(font: UIFont, textColor: UIColor, maskColor: UIColor, cornerRadius: CGFloat) -> Factory<MaskImageView> {
        let factory = { () -> MaskImageView in
            let miv = MaskImageView()
            miv.maskColor = maskColor
            miv.maskLabel.font = font
            miv.maskLabel.textColor = textColor
            miv.cornerRadius = cornerRadius
            return miv
        }
        return factory
    }
}
