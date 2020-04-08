//
//  EmailFormVC.swift
//  Vivex
//
//  Created by Nik, 29/01/2020
//

import Foundation
import UIKit

public class EmailFormVC : UIViewController, EmailFormViewProtocol {
    var presenter : EmailFormPresenterProtocol!
    
    private var mainView: EmailFormView {
        return view as! EmailFormView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = EmailFormView(configurator: presenter.configurator)
        mainView.submitButton.addTarget(self, action: #selector(submitPressed), for: .touchUpInside)
        mainView.textField.textField.becomeFirstResponder()
    }
    
    public func changeState(_ state: EmailFormViewState) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            switch state {
            case .normal:
                (self?.mainView.submitButton as? PrimaryButton)?.primaryState.accept(.normal)
                self?.mainView.contentView.alpha = 1.0
            case .loading:
                (self?.mainView.submitButton as? PrimaryButton)?.primaryState.accept(.loading)
                self?.mainView.contentView.alpha = 0.5
            }
        }
    }
    
    @objc func submitPressed() {
        let email = mainView.textField.getTextValue()
        if !email.isEmpty {
            presenter.submitPressed(email)
        }        
    }
    
    public class func createInstance(presenter : EmailFormPresenterProtocol) -> EmailFormVC {
        let instance = EmailFormVC()
        instance.presenter = presenter
        return instance
    }
}
