//
//  ChatVC.swift
//  Vivex
//
//  Created by Nik, 15/01/2020
//

import Foundation
import UIKit
import iOSBaseViews

public class ChatVC : UIViewController, ChatViewProtocol {
    var presenter : ChatPresenterProtocol!
    
    private var mainView: ChatScrollView {
        return view as! ChatScrollView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public func setupVCs(_ vcs: [UIViewController]) {
        mainView.setupViews(vcs.map({ $0.view }))
        
        for vc in children {
            if !vcs.contains(vc) {
                vc.removeFromParent()
                vc.didMove(toParent: nil)
            }
        }
        
        for vc in vcs {
            if !children.contains(vc) {
                addChild(vc)
                vc.didMove(toParent: self)
            }
        }
        
    }
    
    public override func loadView() {
        view = ChatScrollView(configurator: presenter.configurator)
    }
    
    public class func createInstance(presenter : ChatPresenterProtocol) -> ChatVC {
        let instance = ChatVC()
        instance.presenter = presenter
        return instance
    }
}
