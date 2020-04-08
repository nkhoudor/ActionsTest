//
//  ChatScrollView.swift
//  iOSKyc
//
//  Created by Nik on 16/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation
import PinLayout

public class ChatScrollView : UIScrollView {
    var configurator: ChatConfiguratorProtocol!
    
    var views : [UIView] = []
    
    init(configurator: ChatConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        transform = CGAffineTransform(scaleX: 1, y: -1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var animateFirstView : Bool = false
    
    func setupViews(_ views: [UIView]) {
        for view in self.views {
            if !views.contains(view) {
                view.removeFromSuperview()
            }
        }
        
        self.views = views
        for (i, view) in views.enumerated() {
            if i == 0 {
                animateFirstView = view.superview != self
            }
            
            if view.superview != self {
                addSubview(view)
                view.transform = CGAffineTransform(scaleX: 1, y: -1)
            }
        }
        layoutNeeded = true
        layoutSubviews()
    }
    
    var layoutNeeded : Bool = true
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard layoutNeeded else { return }
        layoutNeeded = false
        
        guard views.count > 0 else { return }
        
        var firstViewSize : CGSize!
        
        if animateFirstView {
            firstViewSize = views.first!.sizeThatFits(frame.size)
            views.first!.pin.size(firstViewSize).top(-firstViewSize.height).hCenter()
        }
        
        UIView.animate(withDuration: 0.5) {
            self.layout()
        }
        
        let safeAreaOffset = pin.safeArea.bottom
        
        if animateFirstView {
            UIView.animate(
                withDuration: 0.5,
                delay: 0.25,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 0.2,
                options: [.curveEaseInOut],
                animations: {
                    self.views.first!.pin.top(10 + safeAreaOffset).hCenter()
            })
        }
        
        animateFirstView = false
        
    }
    
    func layout() {
        var offset : CGFloat = 0.0
        for (i, view) in views.enumerated() {
            let size = view.sizeThatFits(frame.size)
            if i == 0, animateFirstView {
                //view.pin.size(size).top(offset).hCenter()
                offset = size.height + 10 + pin.safeArea.bottom
            } else {
                view.pin.size(size).top(offset).hCenter()
                offset = view.frame.maxY
            }
        }
        contentSize = CGSize(width: frame.width, height: views.last!.frame.maxY + 0)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return size
    }
}

