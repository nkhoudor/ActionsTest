//
//  HalfSceenModalVC.swift
//  Vivex
//
//  Created by Nik, 30/01/2020
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

public class HalfSceenModalVC : UIViewController {
    var configurator: HalfSceenModalConfiguratorProtocol!
    
    let disposeBag = DisposeBag()
    
    weak var baseVC : UIViewController?
    var presentingVCFactory : Factory<UIViewController>!
    
    private var mainView: HalfSceenModalView {
        return view as! HalfSceenModalView
    }
    
    var coverView = UIView()
    
    public override func loadView() {
        if let baseVC = baseVC {
            coverView.alpha = 0.0
            coverView.backgroundColor = configurator.coverColor
            coverView.frame = baseVC.view.bounds
            baseVC.view.addSubview(coverView)
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.coverView.alpha = 1.0
            }
        }
        let presentingVC = presentingVCFactory()
        addChild(presentingVC)
        view = HalfSceenModalView(presentingView: presentingVC.view, configurator: configurator)
        presentingVC.didMove(toParent: self)
        mainView.coverButton.addTarget(self, action: #selector(coverPressed), for: .touchUpInside)
        
        mainView.addGestureRecognizer(swipeGestureRecognizer)
        
        mainView.topArrowImageView.rx.observe(Optional<UIImage>.self, "image").subscribe(onNext: {[weak self] _ in
            UIView.animate(withDuration: 0.2) {
                self?.mainView.layoutSubviews()
            }
        }).disposed(by: disposeBag)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        if isBeingDismissed {
            coverView.removeFromSuperview()
        }
    }
    
    @objc func coverPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    lazy var swipeGestureRecognizer : UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeView(_:)))
        swipe.direction = .down
        return swipe
    }()
    
    @objc func swipeView(_ sender : UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    public class func createInstance(configurator: HalfSceenModalConfiguratorProtocol, presentingVCFactory : @escaping Factory<UIViewController>, baseVC: UIViewController) -> HalfSceenModalVC {
        let instance = HalfSceenModalVC()
        instance.configurator = configurator
        instance.presentingVCFactory = presentingVCFactory
        instance.baseVC = baseVC
        return instance
    }
}
