//
//  SideBarMaskLogoutVC.swift
//  Vivex
//
//  Created by Nik, 9/01/2020
//

import Foundation
import UIKit

public class SideBarMaskLogoutVC : UIViewController, SideBarMaskLogoutViewProtocol {
    var presenter : SideBarMaskLogoutPresenterProtocol!
    
    private var mainView: SideBarMaskLogoutView {
        return view as! SideBarMaskLogoutView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = SideBarMaskLogoutView(configurator: presenter.configurator)
        mainView.maskSwitch.addTarget(self, action: #selector(maskSwitchChanged), for: .valueChanged)
        mainView.logoutButton.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
    }
    
    public class func createInstance(presenter : SideBarMaskLogoutPresenterProtocol) -> SideBarMaskLogoutVC {
        let instance = SideBarMaskLogoutVC()
        instance.presenter = presenter
        return instance
    }
    
    @objc func logoutPressed() {
        presenter.logoutPressed()
    }
    
    @objc func maskSwitchChanged(maskSwitch: UISwitch) {
        presenter.maskSwitchChanged(isOn: maskSwitch.isOn)
    }
    
    public func changeMaskSwitchState(isOn: Bool) {
        mainView.maskSwitch.setOn(isOn, animated: true)
    }
}
