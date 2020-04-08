//
//  FullScreenImageSlideshowView.swift
//  iOSKyc
//
//  Created by Nik on 21/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit

public class FullScreenImageSlideshowView : UIView {
    
    var configurator : FullScreenImageSlideshowConfiguratorProtocol!
    
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    
    let imagesScrollView = UIScrollView()
    var imageItems : [FullScreenImageSlideshowItem] = []
    var maskLayer : CAShapeLayer?
    var slideshowItemImageViews : [SlideshowItemImageView] = []
    var slideshowItemImageViewsContainer = UIView.clearView()
    
    var imageLabel : UILabel!
    
    init(entities: [SlideshowEntity], configurator : FullScreenImageSlideshowConfiguratorProtocol) {
        super.init(frame: .zero)
        backgroundColor = configurator.backgroundColor
        self.configurator = configurator
        
        addSubview(imagesScrollView)
        
        imageLabel = configurator.imageLabelFactory()
        imageLabel.textAlignment = .center
        addSubview(imageLabel)
        imagesScrollView.backgroundColor = .clear
        imagesScrollView.isPagingEnabled = true
        
        for (i, entity) in entities.enumerated() {
            imageItems.append(FullScreenImageSlideshowItem(image: entity.image, maskPadding: pixel * 144))
            imagesScrollView.addSubview(imageItems.last!)
            
            let item = SlideshowItemImageView(itemIndex: i)
            item.image = entity.image
            item.maskColor = configurator.bottomItemMaskColor
            item.cornerRadius = configurator.bottomItemCornerRadius
            slideshowItemImageViews.append(item)
            slideshowItemImageViewsContainer.addSubview(item)
        }
        addSubview(slideshowItemImageViewsContainer)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        imagesScrollView.pin.all()
        
        let size = imagesScrollView.frame.size
        
        imagesScrollView.contentSize = CGSize(width: size.width * CGFloat(imageItems.count), height: size.height)
        
        for (i, item) in imageItems.enumerated() {
            if i == 0 {
                item.pin.left().top().bottom().width(imagesScrollView.frame.width)
            } else {
                item.pin.right(of: imageItems[i-1]).top().bottom().width(imagesScrollView.frame.width)
            }
        }
        
        for (i, item) in slideshowItemImageViews.enumerated() {
            if i == 0 {
                item.pin.topLeft().width(pixel * 60).height(pixel * 60)
            } else {
                item.pin.right(of: slideshowItemImageViews[i-1], aligned: .top).marginLeft(8).width(pixel * 60).height(pixel * 60)
            }
        }
        
        slideshowItemImageViewsContainer.pin.bottom(pixel * 58).hCenter().wrapContent()
        
        imageLabel.pin.top(pixel * 100).horizontally(16).sizeToFit(.width)
        
        if maskLayer != nil {
            maskLayer?.removeFromSuperlayer()
        }
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        let maskPath = UIBezierPath(rect: CGRect(x: 0, y: pixel * 144, width: bounds.size.width, height: bounds.size.height - pixel * 288))
        path.append(maskPath)
        path.usesEvenOddFillRule = true
        
        maskLayer = CAShapeLayer()
        maskLayer!.path = path.cgPath
        maskLayer!.fillRule = .evenOdd
        maskLayer!.fillColor = configurator.maskColor.cgColor
        layer.insertSublayer(maskLayer!, above: imagesScrollView.layer)
        
        
    }
}
