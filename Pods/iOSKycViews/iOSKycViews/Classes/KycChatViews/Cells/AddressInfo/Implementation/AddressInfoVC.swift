//
//  AddressInfoVC.swift
//  Vivex
//
//  Created by Nik, 23/01/2020
//

import Foundation
import UIKit

public class AddressInfoVC : UIViewController, AddressInfoViewProtocol {
    var presenter : AddressInfoPresenterProtocol!
    
    private var mainView: AddressInfoView {
        return view as! AddressInfoView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = AddressInfoView(form: presenter.getAddress(), configurator: presenter.configurator)
    }
    
    public class func createInstance(presenter : AddressInfoPresenterProtocol) -> AddressInfoVC {
        let instance = AddressInfoVC()
        instance.presenter = presenter
        return instance
    }
}
