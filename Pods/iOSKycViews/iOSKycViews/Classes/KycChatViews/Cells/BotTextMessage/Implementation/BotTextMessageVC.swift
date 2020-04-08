//
//  BotTextMessageVC.swift
//  Vivex
//
//  Created by Nik, 16/01/2020
//

import UIKit
import iOSBaseViews

public class BotTextMessageVC : UIViewController, BotTextMessageViewProtocol {
    
    var presenter : BotTextMessagePresenterProtocol!
    
    private var mainView: BotTextMessageView {
        return view as! BotTextMessageView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = BotTextMessageView(configurator: presenter.configurator)
        mainView.showImagesButton.addTarget(self, action: #selector(showImagesPressed), for: .touchUpInside)
    }
    
    public func getImages() -> [UIImage] {
        return mainView.imageViews.map({ $0.image }).filter({ $0 != nil }).map({ $0! })
    }
    
    @objc func showImagesPressed() {
        presenter.showImagesPressed()
    }
    
    public func update(text: String) {
        mainView.messageLabel.text = text
    }
    
    public func update(avatarVisible: Bool) {
        mainView.botAvatarImageView.alpha = avatarVisible ? 1.0 : 0.0
    }
    
    public func update(warningVisible: Bool) {
        mainView.update(warningVisible: warningVisible)
    }
    
    public func update(images: [ConfigurationFactory<UIImageView>]) {
        mainView.updateImages(images)
    }
    
    public class func createInstance(presenter : BotTextMessagePresenterProtocol) -> BotTextMessageVC {
        let instance = BotTextMessageVC()
        instance.presenter = presenter
        return instance
    }
}
