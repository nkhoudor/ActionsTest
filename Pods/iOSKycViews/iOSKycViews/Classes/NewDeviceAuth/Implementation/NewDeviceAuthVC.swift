//
//  NewDeviceAuthVC.swift
//  Vivex
//
//  Created by Nik, 8/02/2020
//

import Foundation
import UIKit

public class NewDeviceAuthVC : UIViewController, NewDeviceAuthViewProtocol {
    var presenter : NewDeviceAuthPresenterProtocol!
    
    private var mainView: NewDeviceAuthView {
        return view as! NewDeviceAuthView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }
    
    public override func loadView() {
        view = NewDeviceAuthView(configurator: presenter.configurator)
        mainView.confirmButton.addTarget(self, action: #selector(confirmPressed), for: .touchUpInside)
        mainView.denyButton.addTarget(self, action: #selector(confirmPressed), for: .touchUpInside)
    }
    
    @objc func confirmPressed() {
        presenter.confirmPressed()
    }
    
    @objc func denyPressed() {
        presenter.denyPressed()
    }
    
    public class func createInstance(presenter : NewDeviceAuthPresenterProtocol) -> NewDeviceAuthVC {
        let instance = NewDeviceAuthVC()
        instance.presenter = presenter
        return instance
    }
    
    public func getConfirmButton() -> UIButton {
        return mainView.confirmButton
    }
}
