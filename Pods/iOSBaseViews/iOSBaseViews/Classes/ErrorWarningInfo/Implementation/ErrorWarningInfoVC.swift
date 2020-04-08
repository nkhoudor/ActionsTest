//
//  ErrorWarningInfoVC.swift
//  Vivex
//
//  Created by Nik, 11/02/2020
//

import Foundation
import UIKit

public class ErrorWarningInfoVC : UIViewController, ErrorWarningInfoViewProtocol {
    var presenter : ErrorWarningInfoPresenterProtocol!
    
    private var mainView: ErrorWarningInfoView {
        return view as! ErrorWarningInfoView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = ErrorWarningInfoView(configurator: presenter.configurator)
    }
    
    public class func createInstance(presenter : ErrorWarningInfoPresenterProtocol) -> ErrorWarningInfoVC {
        let instance = ErrorWarningInfoVC()
        instance.presenter = presenter
        return instance
    }
}
