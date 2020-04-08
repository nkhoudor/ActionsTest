//
//  ScrollStackVC.swift
//  Vivex
//
//  Created by Nik, 6/01/2020
//

import Foundation
import UIKit

public class ScrollStackVC : UIViewController, ScrollStackViewProtocol {
    var presenter : ScrollStackPresenterProtocol!
    
    internal var mainView: ScrollStackView {
        return view as! ScrollStackView
    }
    
    public override func loadView() {
        
        assert(presenter.configurator.margins.count == presenter.configurator.modules.count + 1, "Margins count should be modules count + 1")
        
        view = ScrollStackView(configurator: presenter.configurator)
        
        for moduleFactory in presenter.configurator.modules {
            let module = moduleFactory()
            addChild(module)
        }
        
        mainView.setupViews(children.map({ $0.view }))
        children.forEach({ $0.didMove(toParent: self) })
    }
    
    public class func createInstance(presenter : ScrollStackPresenterProtocol) -> ScrollStackVC {
        let instance = ScrollStackVC()
        instance.presenter = presenter
        presenter.viewInited(view: instance)
        return instance
    }
}
