//
//  SideBarSupportVC.swift
//  Vivex
//
//  Created by Nik, 9/01/2020
//

import Foundation
import UIKit

public class SideBarSupportVC : UIViewController, SideBarSupportViewProtocol {
    var presenter : SideBarSupportPresenterProtocol!
    
    private var mainView: SideBarSupportView {
        return view as! SideBarSupportView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = SideBarSupportView(configurator: presenter.configurator)
        mainView.supportButton.addTarget(self, action: #selector(supportPressed), for: .touchUpInside)
    }
    
    public class func createInstance(presenter : SideBarSupportPresenterProtocol) -> SideBarSupportVC {
        let instance = SideBarSupportVC()
        instance.presenter = presenter
        return instance
    }
    
    @objc func supportPressed() {
        presenter.supportPressed()
    }
}
