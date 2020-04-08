//
//  SideBarScrollStackVC.swift
//  iOSBaseViews
//
//  Created by Nik on 09/01/2020.
//

import Foundation
import OverlayContainer

public class SideBarScrollStackVC : ScrollStackVC {
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    lazy var maxOffset : CGFloat = 120.0 * pixel / 3.75
    
    public override class func createInstance(presenter: ScrollStackPresenterProtocol) -> ScrollStackVC {
        let instance = SideBarScrollStackVC()
        instance.presenter = presenter
        presenter.viewInited(view: instance)
        return instance
    }
}

extension SideBarScrollStackVC : OverlayTransitionDelegate {
    public func transition(transitionCoordinator: OverlayContainerTransitionCoordinator) {
        var offset = (UIScreen.main.bounds.height - 84 * pixel - transitionCoordinator.targetTranslationHeight) / 3.75
        if offset < 0 {
            offset = 0
        }
        if offset > maxOffset {
            offset = maxOffset
        }
        if offset == 0 || offset == maxOffset {
            UIView.animate(withDuration: 0.15) { [weak self] in
                self?.updateView(offset: offset)
            }
        } else {
            updateView(offset: offset)
        }
    }
    
    private func updateView(offset: CGFloat) {
        let frame = mainView.frame
        if frame.origin.y != -offset {
            let newFrame = CGRect(x: frame.origin.x, y: -offset, width: frame.size.width, height: frame.size.height)
            mainView.frame = newFrame
        }
        
        for (i, view) in mainView.subviews.enumerated() {
            if (i == 0) {
                view.alpha = (maxOffset - offset) / maxOffset
            } else {
                view.alpha = 1.0 - (maxOffset - offset) / maxOffset
            }
        }
    }
}
