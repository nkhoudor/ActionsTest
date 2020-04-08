//
//  SwipeModalVC.swift
//  iOSKyc
//
//  Created by Nik on 19/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

open class SwipeModalVC : UIViewController {
    
    var presentedVC : UIViewController!
    var configurator : SwipeModalConfiguratorProtocol!
    
    let disposeBag = DisposeBag()
    
    private var mainView: SwipeModalView {
        return view as! SwipeModalView
    }
    
    public init(presentedVC : UIViewController, configurator: SwipeModalConfiguratorProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.presentedVC = presentedVC
        self.configurator = configurator
    }
    
    /*lazy var panGestureRecognizer : UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        return pan
    }()*/
    
    lazy var swipeGestureRecognizer : UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeView(_:)))
        swipe.direction = .down
        return swipe
    }()
    
    @objc func swipeView(_ sender : UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    /*@objc func draggedView(_ sender : UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            let translation = sender.translation(in: view)
            if view.frame.minY + translation.y >= 0 {
                view.center = CGPoint(x: view.center.x, y: view.center.y + translation.y)
            }
            sender.setTranslation(CGPoint.zero, in: view)
        case .ended:
            if view.frame.origin.y > 120 {
                dismiss(animated: true, completion: nil)
            } else if let frame = UIApplication.shared.keyWindow?.frame {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.view.frame = frame
                }
            }
        default:
            ()
        }
    }*/
    
    open override func loadView() {
        addChild(presentedVC)
        view = SwipeModalView(presentedView: presentedVC.view, configurator: configurator)
        presentedVC.didMove(toParent: self)
        mainView.addGestureRecognizer(swipeGestureRecognizer)
        
        mainView.arrowImageView.rx.observe(Optional<UIImage>.self, "image").subscribe(onNext: {[weak self] _ in
            UIView.animate(withDuration: 0.2) {
                self?.mainView.layoutSubviews()
            }
        }).disposed(by: disposeBag)
        
        mainView.arrowButton.addTarget(self, action: #selector(closePressed), for: .touchUpInside)
    }
    
    @objc func closePressed() {
        dismiss(animated: true, completion: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
