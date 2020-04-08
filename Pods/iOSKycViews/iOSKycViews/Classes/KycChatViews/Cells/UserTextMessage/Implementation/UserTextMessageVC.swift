//
//  UserTextMessageVC.swift
//  Vivex
//
//  Created by Nik, 17/01/2020
//

import Foundation
import UIKit

public class UserTextMessageVC : UIViewController, UserTextMessageViewProtocol {
    var presenter : UserTextMessagePresenterProtocol!
    
    private var mainView: UserTextMessageView {
        return view as! UserTextMessageView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = UserTextMessageView(configurator: presenter.configurator)
    }
    
    public func update(text: String) {
        mainView.messageLabel.text = text
    }
    
    public class func createInstance(presenter : UserTextMessagePresenterProtocol) -> UserTextMessageVC {
        let instance = UserTextMessageVC()
        instance.presenter = presenter
        return instance
    }
}
