//
//  SideBarActionsSetVC.swift
//  Vivex
//
//  Created by Nik, 8/01/2020
//

import Foundation
import UIKit

public class SideBarActionsSetVC : UIViewController, SideBarActionsSetViewProtocol {
    var presenter : SideBarActionsSetPresenterProtocol!
    
    private var mainView: SideBarActionsSetView {
        return view as! SideBarActionsSetView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = SideBarActionsSetView(configurator: presenter.configurator)
    }
    
    public class func createInstance(presenter : SideBarActionsSetPresenterProtocol) -> SideBarActionsSetVC {
        let instance = SideBarActionsSetVC()
        instance.presenter = presenter
        return instance
    }
    
    public class func createInstance(configurator: SideBarActionsSetConfiguratorProtocol) -> SideBarActionsSetVC {
        let instance = SideBarActionsSetVC()
        instance.presenter = SideBarActionsSetPresenter(interactor: SideBarActionsSetInteractor(), router: SideBarActionsSetRouter(), configurator: configurator)
        return instance
    }
}
