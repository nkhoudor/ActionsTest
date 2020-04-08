//
//  PhoneRegistrationVC.swift
//  Vivex
//
//  Created by Nik, 1/01/2020
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import iOSBaseViews

public class PhoneRegistrationVC : UIViewController, PhoneRegistrationViewProtocol {
    public var presenter : PhoneRegistrationPresenterProtocol!
    
    let disposeBag = DisposeBag()
    
    private var mainView: PhoneRegistrationView {
        return view as! PhoneRegistrationView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = PhoneRegistrationView(configurator : presenter.configurator)
        mainView.continueButton.addTarget(self, action: #selector(continuePressed), for: .touchUpInside)
        mainView.phoneTextField.delegate = self
        mainView.logoImageView.rx.observe(Optional<UIImage>.self, "image").withPrevious(startWith: nil).subscribe(onNext: {[weak self] change in
            guard change.previous != change.current else { return }
            UIView.animate(withDuration: 0.2) {
                self?.mainView.layoutSubviews()
            }
        }).disposed(by: disposeBag)
        
        mainView.phoneTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    @objc func editingChanged() {
        if mainView.errorLabel.alpha == 1.0 {
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.mainView.contentView.alpha = 1.0
                self?.mainView.errorLabel.alpha = 0.0
                self?.mainView.continueButton.primaryState.accept(.normal)
            }
        }
    }
    
    @objc func continuePressed() {
        presenter.registerPhone(phone: mainView.phoneTextField.text ?? "")
    }
    
    public func changeState(_ state: PhoneRegistrationViewState) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            switch state {
            case .normal:
                self?.mainView.contentView.alpha = 1.0
                self?.mainView.errorLabel.alpha = 0.0
                self?.mainView.continueButton.primaryState.accept(.normal)
                self?.mainView.phoneTextField.text = "+"
            case .loading:
                self?.mainView.contentView.alpha = 0.5
                self?.mainView.errorLabel.alpha = 0.0
                self?.mainView.continueButton.primaryState.accept(.loading)
            case .error:
                self?.mainView.contentView.alpha = 1.0
                self?.mainView.errorLabel.alpha = 1.0
                self?.mainView.continueButton.primaryState.accept(.normal)
            case .success:
                self?.mainView.contentView.alpha = 1.0
                self?.mainView.errorLabel.alpha = 0.0
                self?.mainView.continueButton.primaryState.accept(.success)
            }
        }
    }
    
    public class func createInstance(presenter : PhoneRegistrationPresenterProtocol) -> PhoneRegistrationVC {
        let instance = PhoneRegistrationVC()
        instance.presenter = presenter
        return instance
    }
}

extension PhoneRegistrationVC : UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if var text = textField.text {
            if range.location == 0 && range.length == 1 {
                return false
            }
            if range.location == 0 && text.count > 0 {
                if string == "" {
                    text.removeSubrange(text.index(text.startIndex, offsetBy: 1)..<text.index(text.startIndex, offsetBy: range.length))
                    textField.text = text
                    return false
                } else {
                    let position = textField.position(from: textField.beginningOfDocument, offset: 1)!
                    textField.selectedTextRange = textField.textRange(from: position, to: position)
                }
            }
        }
        return true
    }
}
