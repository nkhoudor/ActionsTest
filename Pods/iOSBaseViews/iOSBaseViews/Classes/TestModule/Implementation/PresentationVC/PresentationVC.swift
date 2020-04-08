//
//  PresentationVC.swift
//  iOSBaseViews_Example
//
//  Created by Nik on 01/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import PinLayout

class PresentationVC: UIViewController {
    
    var presentedVC : UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = PresentationView(subView: presentedVC.view)
        addChild(presentedVC)
        presentedVC.didMove(toParent: self)
    }
    
    public class func createInstance(presentedVC : UIViewController) -> PresentationVC {
        let vc = PresentationVC()
        vc.presentedVC = presentedVC
        return vc
    }
}
