//
//  MainHolderVC.swift
//  Vivex
//
//  Created by Nik, 9/01/2020
//

import Foundation
import UIKit
import OverlayContainer
import RxSwift
import RxCocoa

public class MainHolderVC : UIViewController, MainHolderViewProtocol {
    var presenter : MainHolderPresenterProtocol!
    
    weak var mainHolderDelegate : MainHolderDelegate?
    
    let disposeBag = DisposeBag()
    
    private var mainView: MainHolderView {
        return view as! MainHolderView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    @objc func backPressed() {
        presenter.backPressed()
    }
    
    @objc func closePressed() {
        presenter.closePressed()
    }
    
    @objc func expandPressed() {
        mainHolderDelegate?.expandMainHolder()
    }
    
    public override func loadView() {
        let mainVC = presenter.configurator.mainVCFactory()
        addChild(mainVC)
        view = MainHolderView(configurator: presenter.configurator, mainView: mainVC.view)
        mainVC.didMove(toParent: self)
        
        mainView.backButton?.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        mainView.closeButton?.addTarget(self, action: #selector(closePressed), for: .touchUpInside)
        mainView.expandButton.addTarget(self, action: #selector(expandPressed), for: .touchUpInside)
        
        mainView.backImageView?.rx.observe(Optional<UIImage>.self, "image").withPrevious(startWith: nil).subscribe(onNext: {[weak self] change in
            guard change.previous != change.current else { return }
            UIView.animate(withDuration: 0.2) {
                self?.mainView.layoutSubviews()
            }
        }).disposed(by: disposeBag)
        mainView.closeImageView?.rx.observe(Optional<UIImage>.self, "image").withPrevious(startWith: nil).subscribe(onNext: {[weak self] change in
            guard change.previous != change.current else { return }
            UIView.animate(withDuration: 0.2) {
                self?.mainView.layoutSubviews()
            }
        }).disposed(by: disposeBag)
        mainView.topArrowImageView.rx.observe(Optional<UIImage>.self, "image").withPrevious(startWith: nil).subscribe(onNext: {[weak self] change in
            guard change.previous != change.current else { return }
            UIView.animate(withDuration: 0.2) {
                self?.mainView.layoutSubviews()
            }
        }).disposed(by: disposeBag)
    }
    
    public class func createInstance(presenter : MainHolderPresenterProtocol) -> MainHolderVC {
        let instance = MainHolderVC()
        instance.presenter = presenter
        return instance
    }
}

extension MainHolderVC : OverlayTransitionDelegate {
    public func transition(transitionCoordinator: OverlayContainerTransitionCoordinator) {
        mainView.topArrowImageView.alpha = 1.0 - transitionCoordinator.overallTranslationProgress()
        mainView.nameLabel?.alpha = 1.0 - transitionCoordinator.overallTranslationProgress()
        mainView.expandButton.alpha = 1.0 - transitionCoordinator.overallTranslationProgress()
        
        mainView.headerView?.alpha = transitionCoordinator.overallTranslationProgress()
        mainView.mainView.alpha = transitionCoordinator.overallTranslationProgress()
        mainView.backImageView?.alpha = transitionCoordinator.overallTranslationProgress()
        mainView.backButton?.alpha = transitionCoordinator.overallTranslationProgress()
        mainView.closeImageView?.alpha = transitionCoordinator.overallTranslationProgress()
        mainView.closeButton?.alpha = transitionCoordinator.overallTranslationProgress()
    }
}
