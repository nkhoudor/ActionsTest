//
//  RestrictedCountryPopupVC.swift
//  Vivex
//
//  Created by Nik, 30/01/2020
//

import Foundation
import UIKit

public class RestrictedCountryPopupVC : UIViewController, RestrictedCountryPopupViewProtocol {
    var presenter : RestrictedCountryPopupPresenterProtocol!
    
    private var mainView: RestrictedCountryPopupView {
        return view as! RestrictedCountryPopupView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = RestrictedCountryPopupView(configurator: presenter.configurator)
        mainView.changeNumberButton.addTarget(self, action: #selector(changeNumberPressed), for: .touchUpInside)
    }
    
    @objc func changeNumberPressed() {
        presenter.changeNumberPressed()
    }
    
    public func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    public class func createInstance(presenter : RestrictedCountryPopupPresenterProtocol) -> RestrictedCountryPopupVC {
        let instance = RestrictedCountryPopupVC()
        instance.presenter = presenter
        return instance
    }
}
