//
//  TestModuleVC.swift
//  Vivex
//
//  Created by Nik, 7/01/2020
//

import Foundation
import UIKit

public class TestModuleVC : UIViewController, TestModuleViewProtocol {
    var presenter : TestModulePresenterProtocol!
    
    private var mainView: TestModuleView {
        return view as! TestModuleView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = TestModuleView(configurator: presenter.configurator)
        mainView.delegate = self
    }
    
    public class func createInstance(presenter : TestModulePresenterProtocol) -> TestModuleVC {
        let instance = TestModuleVC()
        instance.presenter = presenter
        return instance
    }
    
    public func setupModules(_ modules: [TestModuleFactory]) {
        mainView.configure(modules: modules)
    }
    
}

extension TestModuleVC : TestModuleViewDelegate {
    func moduleSelected(module: TestModuleFactory) {
        if module.usePresentation {
            navigationController?.pushViewController(PresentationVC.createInstance(presentedVC: module.controller()), animated: true)
        } else {
            navigationController?.pushViewController(module.controller(), animated: true)
        }
    }
}
