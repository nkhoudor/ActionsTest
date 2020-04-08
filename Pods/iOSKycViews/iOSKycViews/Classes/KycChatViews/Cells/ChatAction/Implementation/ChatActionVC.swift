//
//  ChatActionVC.swift
//  Vivex
//
//  Created by Nik, 17/01/2020
//

import Foundation
import UIKit

public class ChatActionVC : UIViewController, ChatActionViewProtocol {
    var presenter : ChatActionPresenterProtocol!
    
    private var mainView: ChatActionView {
        return view as! ChatActionView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    @objc func firstButtonPressed() {
        presenter.firstButtonPressed()
    }
    
    @objc func secondButtonPressed() {
        presenter.secondButtonPressed()
    }
    
    public override func loadView() {
        view = ChatActionView(configurator: presenter.configurator)
        mainView.firstButton.addTarget(self, action: #selector(firstButtonPressed), for: .touchUpInside)
        mainView.secondButton?.addTarget(self, action: #selector(secondButtonPressed), for: .touchUpInside)
    }
    
    public class func createInstance(presenter : ChatActionPresenterProtocol) -> ChatActionVC {
        let instance = ChatActionVC()
        instance.presenter = presenter
        return instance
    }
}
