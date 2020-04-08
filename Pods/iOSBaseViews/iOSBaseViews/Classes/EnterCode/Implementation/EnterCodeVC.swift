//
//  EnterCodeVC.swift
//  Vivex
//
//  Created by Nik, 6/01/2020
//

import Foundation
import UIKit

public class EnterCodeVC : UIViewController, EnterCodeViewProtocol {
    var presenter : EnterCodePresenterProtocol!
    
    private var mainView: EnterCodeView {
        return view as! EnterCodeView
    }
    
    var code : String {
        return mainView.numfields.map({ $0.text ?? "" }).reduce("", { $0 + $1 })
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = EnterCodeView(configurator: presenter.configurator)
        mainView.numfields[0].becomeFirstResponder()
        mainView.numfields.forEach({
            $0.delegate = self
            $0.numDelegate = self
        })
        mainView.resendButton.addTarget(self, action: #selector(resendPressed), for: .touchUpInside)
    }
    
    public class func createInstance(presenter : EnterCodePresenterProtocol) -> EnterCodeVC {
        let instance = EnterCodeVC()
        instance.presenter = presenter
        return instance
    }
    
    @objc func resendPressed() {
        presenter.resendPressed()
    }
    
    public func changeResendState(_ state: ResendState) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            switch state {
            case .allowed:
                self?.mainView.resendButton.alpha = 1.0
                self?.mainView.resendCodeInLabel.alpha = 0.0
            case .resend(let seconds):
                self?.mainView.resendButton.alpha = 0.0
                self?.mainView.resendCodeInLabel.alpha = 1.0
                self?.mainView.updateResendInLabel(seconds: seconds)
            }
        }
    }
    
    public func changeState(_ state: EnterCodeViewState) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            switch state {
            case .normal:
                self?.mainView.numfields.forEach({ $0.numState.accept(.normal) })
                self?.mainView.contentView.alpha = 1.0
                self?.mainView.errorView.alpha = 0.0
                self?.mainView.activityIndicator.alpha = 0.0
                self?.mainView.resendView.alpha = 1.0
                self?.mainView.numfieldsView.alpha = 1.0
            case .error:
                self?.mainView.numfields.forEach({
                    $0.numState.accept(.error)
                })
                self?.mainView.contentView.alpha = 1.0
                self?.mainView.errorView.alpha = 0.0
                self?.mainView.activityIndicator.alpha = 0.0
                self?.mainView.resendView.alpha = 1.0
                
                self?.mainView.numfieldsView.alpha = 1.0
                
            case .error_description:
                self?.mainView.numfields.forEach({
                    $0.numState.accept(.error)
                })
                self?.mainView.contentView.alpha = 1.0
                self?.mainView.errorView.alpha = 1.0
                self?.mainView.activityIndicator.alpha = 0.0
                self?.mainView.resendView.alpha = 1.0
                self?.mainView.numfieldsView.alpha = 0.0
            case .success:
                self?.mainView.numfields.forEach({ $0.numState.accept(.success) })
                self?.mainView.contentView.alpha = 1.0
                self?.mainView.errorView.alpha = 0.0
                self?.mainView.activityIndicator.alpha = 0.0
                self?.mainView.resendView.alpha = 0.0
                self?.mainView.numfieldsView.alpha = 1.0
            case .clear:
                self?.mainView.numfields.forEach({
                    $0.numState.accept(.normal)
                    $0.text = ""
                })
                self?.mainView.numfields[0].becomeFirstResponder()
                self?.mainView.contentView.alpha = 1.0
                self?.mainView.errorView.alpha = 0.0
                self?.mainView.activityIndicator.alpha = 0.0
                self?.mainView.resendView.alpha = 1.0
                self?.mainView.numfieldsView.alpha = 1.0
            case .loading:
                self?.mainView.contentView.alpha = 0.5
                self?.mainView.activityIndicator.alpha = 1.0
                self?.mainView.resendView.alpha = 0.0
                self?.mainView.errorView.alpha = 0.0
                self?.mainView.numfieldsView.alpha = 1.0
            }
        }
    }
}

extension EnterCodeVC : UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        changeState(.normal)
        textField.text = string
        if !string.isEmpty {
            if let index = mainView.numfields.firstIndex(of: textField as! NumTextField) {
                if index < mainView.numfields.count - 1 {
                    mainView.numfields[index+1].becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                    presenter.codeEntered(code)
                }
            }
        }
        return false
    }
}

extension EnterCodeVC : NumTextFieldDelegate {
    public func deleteBackward(textField: NumTextField) {
        changeState(.normal)
        if let index = mainView.numfields.firstIndex(of: textField) {
            if index > 0 {
                mainView.numfields[index-1].text = ""
                mainView.numfields[index-1].becomeFirstResponder()
            }
        }
    }
}
