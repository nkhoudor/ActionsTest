//
//  SideBarLogoVC.swift
//  Vivex
//
//  Created by Nik, 9/01/2020
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

public class SideBarLogoVC : UIViewController, SideBarLogoViewProtocol {
    var presenter : SideBarLogoPresenterProtocol!
    let disposeBag = DisposeBag()
    
    private var mainView: SideBarLogoView {
        return view as! SideBarLogoView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = SideBarLogoView(configurator: presenter.configurator)        
        mainView.logoImageView.rx.observe(Optional<UIImage>.self, "image").withPrevious(startWith: nil).subscribe(onNext: {[weak self] change in
            guard change.previous != change.current else { return }
            UIView.animate(withDuration: 0.2) {
                self?.mainView.superview?.layoutSubviews()
            }
        }).disposed(by: disposeBag)
    }
    
    public class func createInstance(presenter : SideBarLogoPresenterProtocol) -> SideBarLogoVC {
        let instance = SideBarLogoVC()
        instance.presenter = presenter
        return instance
    }
    
    public class func createInstance(configurator : SideBarLogoConfiguratorProtocol) -> SideBarLogoVC {
        let instance = SideBarLogoVC()
        instance.presenter = SideBarLogoPresenter(interactor: SideBarLogoInteractor(), router: SideBarLogoRouter(), configurator: configurator)
        return instance
    }
}
