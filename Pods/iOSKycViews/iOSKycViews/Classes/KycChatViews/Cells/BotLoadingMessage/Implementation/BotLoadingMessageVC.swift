//
//  BotLoadingMessageVC.swift
//  Vivex
//
//  Created by Nik, 21/01/2020
//

import Foundation
import UIKit

public class BotLoadingMessageVC : UIViewController, BotLoadingMessageViewProtocol {
    var presenter : BotLoadingMessagePresenterProtocol!
    
    private var mainView: BotLoadingMessageView {
        return view as! BotLoadingMessageView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = BotLoadingMessageView(configurator: presenter.configurator)
    }
    
    public func update(avatarVisible: Bool) {
        mainView.botAvatarImageView.alpha = avatarVisible ? 1.0 : 0.0
    }
    
    public class func createInstance(presenter : BotLoadingMessagePresenterProtocol) -> BotLoadingMessageVC {
        let instance = BotLoadingMessageVC()
        instance.presenter = presenter
        return instance
    }
}
