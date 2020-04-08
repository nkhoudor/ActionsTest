//
//  FullScreenImageSlideshowItem.swift
//  iOSKyc
//
//  Created by Nik on 21/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import PinLayout

public class FullScreenImageSlideshowItem : UIScrollView {
    
    let imageView = UIImageView()
    var maskPadding : CGFloat
    
    init(image: UIImage, maskPadding: CGFloat) {
        self.maskPadding = maskPadding
        super.init(frame: .zero)
        backgroundColor = .clear

        addSubview(imageView)
        
        imageView.clipsToBounds = false
        imageView.isUserInteractionEnabled = true
        imageView.image = image
        imageView.frame.size = image.size
        imageView.backgroundColor = .clear

        delegate = self
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        minimumZoomScale = 1.0
        maximumZoomScale = 2.0
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateZoomScales() {
        guard let image = imageView.image else { return }
        
        var minimumZoomScale : CGFloat!
        
        if image.size.height > image.size.width {
            minimumZoomScale = (frame.height - maskPadding * 2) / image.size.height
        } else {
            minimumZoomScale = frame.width / image.size.width
        }
        
        if self.minimumZoomScale != minimumZoomScale {
            self.minimumZoomScale = minimumZoomScale
            maximumZoomScale = minimumZoomScale * 3
            setZoomScale(minimumZoomScale, animated: false)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if zoomScale == minimumZoomScale {
            imageView.pin.center()
        }
        updateZoomScales()
    }
}

extension FullScreenImageSlideshowItem : UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
