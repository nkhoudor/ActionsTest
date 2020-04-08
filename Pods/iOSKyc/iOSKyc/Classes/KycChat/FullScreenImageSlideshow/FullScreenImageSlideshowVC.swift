//
//  FullScreenImageSlideshowVC.swift
//  iOSKyc
//
//  Created by Nik on 21/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit

public class FullScreenImageSlideshowVC : UIViewController {
    var configurator : FullScreenImageSlideshowConfiguratorProtocol!
    
    var entities : [SlideshowEntity]!
    
    private var mainView: FullScreenImageSlideshowView {
        return view as! FullScreenImageSlideshowView
    }
    
    public override func loadView() {
        view = FullScreenImageSlideshowView(entities: entities, configurator: configurator)
        mainView.imagesScrollView.delegate = self
        mainView.slideshowItemImageViews.select(0)
        mainView.imageLabel.text = entities.first?.text
        for item in mainView.slideshowItemImageViews {
            item.button.addTarget(self, action: #selector(slideshowItemPressed(_:)), for: .touchUpInside)
        }
    }
    
    @objc func slideshowItemPressed(_ sender: UIButton) {
        guard let item = sender.superview as? SlideshowItemImageView else { return }
        mainView.imagesScrollView.setContentOffset(CGPoint(x: mainView.imagesScrollView.frame.width * CGFloat(item.itemIndex), y: 0), animated: true)
    }
    
    public class func createInstance(entities: [SlideshowEntity], configurator : FullScreenImageSlideshowConfiguratorProtocol) -> FullScreenImageSlideshowVC {
        let instance = FullScreenImageSlideshowVC()
        instance.configurator = configurator
        instance.entities = entities
        return instance
    }
}

extension FullScreenImageSlideshowVC : UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int((scrollView.contentOffset.x + scrollView.frame.size.width / 2) / scrollView.frame.size.width)
        mainView.slideshowItemImageViews.select(page)
        mainView.imageLabel.text = entities[page].text
    }
}
