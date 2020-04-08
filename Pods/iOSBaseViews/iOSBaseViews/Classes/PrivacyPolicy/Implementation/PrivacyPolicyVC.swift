//
//  PrivacyPolicyVC.swift
//  Vivex
//
//  Created by Nik, 28/01/2020
//

import Foundation
import UIKit

public class PrivacyPolicyVC : UIViewController, PrivacyPolicyViewProtocol {
    var presenter : PrivacyPolicyPresenterProtocol!
    
    private var mainView: PrivacyPolicyView {
        return view as! PrivacyPolicyView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = PrivacyPolicyView(configurator: presenter.configurator)
        mainView.confirmButton.addTarget(self, action: #selector(confirmPressed), for: .touchUpInside)
        mainView.denyButton.addTarget(self, action: #selector(denyPressed), for: .touchUpInside)
    }
    
    @objc func confirmPressed() {
        presenter.confirmPressed()
    }
    
    @objc func denyPressed() {
        presenter.denyPressed()
    }
    
    public class func createInstance(presenter : PrivacyPolicyPresenterProtocol) -> PrivacyPolicyVC {
        let instance = PrivacyPolicyVC()
        instance.presenter = presenter
        return instance
    }
}
