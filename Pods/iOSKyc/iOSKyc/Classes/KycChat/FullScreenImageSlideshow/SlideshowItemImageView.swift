//
//  SlideshowItemImageView.swift
//  iOSKyc
//
//  Created by Nik on 22/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import RxSwift
import RxRelay

public extension Array where Element == SlideshowItemImageView {
    func select(_ index: Int) {
        let currentSelected = self.firstIndex(where: { $0.maskLayer.isHidden })
        
        if currentSelected == nil {
            self[index].maskLayer?.isHidden = true
        } else if currentSelected != index {
            self[currentSelected!].maskLayer?.isHidden = false
            self[index].maskLayer?.isHidden = true
        }
    }
}

public class SlideshowItemImageView : UIImageView {
    
    var maskColor : UIColor!
    var cornerRadius : CGFloat!
    var maskLayer : CAShapeLayer!
    var maskXOffset : CGFloat = 0 {
        didSet {
            maskLayer!.path = UIBezierPath(roundedRect: CGRect(x: maskXOffset, y: 0, width: bounds.size.width, height: bounds.size.height), cornerRadius: cornerRadius).cgPath
        }
    }
    let button = UIButton()
    var itemIndex : Int
    
    init(itemIndex: Int) {
        self.itemIndex = itemIndex
        super.init(frame: .zero)
        maskLayer = CAShapeLayer()
        layer.insertSublayer(maskLayer, at: 0)
        contentMode = .scaleAspectFill
        clipsToBounds = true
        addSubview(button)
        isUserInteractionEnabled = true
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        maskLayer.path = UIBezierPath(roundedRect: CGRect(x: maskXOffset, y: 0, width: bounds.size.width, height: bounds.size.height), cornerRadius: cornerRadius).cgPath
        maskLayer.fillColor = maskColor.cgColor
        button.pin.all()
    }
}
