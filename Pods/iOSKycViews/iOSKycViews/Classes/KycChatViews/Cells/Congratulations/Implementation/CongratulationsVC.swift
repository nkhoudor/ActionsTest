//
//  CongratulationsVC.swift
//  Vivex
//
//  Created by Nik, 23/01/2020
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import iOSBaseViews

public class CongratulationsVC : UIViewController, CongratulationsViewProtocol {
    var presenter : CongratulationsPresenterProtocol!
    
    let disposeBag = DisposeBag()
    
    private var mainView: CongratulationsView {
        return view as! CongratulationsView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = CongratulationsView(configurator: presenter.configurator)
        mainView.successImageView.rx.observe(Optional<UIImage>.self, "image").subscribe(onNext: {[weak self] _ in
            UIView.animate(withDuration: 0.2) {
                self?.mainView.layoutSubviews()
            }
        }).disposed(by: disposeBag)
        
        mainView.successImageView.rx.observe(Optional<UIImage>.self, "image").withPrevious(startWith: nil).subscribe(onNext: {[weak self] change in
            guard change.previous != change.current else { return }
            UIView.animate(withDuration: 0.2) {
                self?.mainView.superview?.layoutSubviews()
            }
        }).disposed(by: disposeBag)
        
        mainView.whatsNextButton?.addTarget(self, action: #selector(whatsNextPressed), for: .touchUpInside)
    }
    
    @objc func whatsNextPressed() {
        presenter.whatsNextPressed()
    }
    
    public class func createInstance(presenter : CongratulationsPresenterProtocol) -> CongratulationsVC {
        let instance = CongratulationsVC()
        instance.presenter = presenter
        return instance
    }
}
