//
//  SideBarVC.swift
//  Vivex
//
//  Created by Nik, 8/01/2020
//

import Foundation
import UIKit

public class SideBarVC : UIViewController, SideBarViewProtocol {
    var presenter : SideBarPresenterProtocol!
    
    private var mainView: SideBarView {
        return view as! SideBarView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = SideBarView(configurator: presenter.configurator)
    }
    
    public class func createInstance(presenter : SideBarPresenterProtocol) -> SideBarVC {
        let instance = SideBarVC()
        instance.presenter = presenter
        return instance
    }
}
