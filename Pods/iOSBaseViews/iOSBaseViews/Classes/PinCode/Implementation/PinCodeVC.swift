//
//  PinCodeVC.swift
//  Vivex
//
//  Created by Nik, 4/01/2020
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

public class PinCodeVC : UIViewController, PinCodeViewProtocol {
    var presenter : PinCodePresenterProtocol!
    var pincode : String = ""
    
    let disposeBag = DisposeBag()
    
    private var mainView: PinCodeView {
        return view as! PinCodeView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
        for numpad in mainView.numpads {
            numpad.delegate = self
        }
        mainView.eraseButton.addTarget(self, action: #selector(erasePressed), for: .touchUpInside)
        mainView.policyButton?.addTarget(self, action: #selector(policyPressed), for: .touchUpInside)
        mainView.biometricsButton?.addTarget(self, action: #selector(biometricsPressed), for: .touchUpInside)
        mainView.forgotButton?.addTarget(self, action: #selector(forgotPressed), for: .touchUpInside)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pincode = ""
        changeState(.normal)
    }
    
    public override func loadView() {
        view = PinCodeView(configurator: presenter.configurator)
        
        mainView.logoImageView.rx.observe(Optional<UIImage>.self, "image").withPrevious(startWith: nil).subscribe(onNext: {[weak self] change in
            guard change.previous != change.current else { return }
            UIView.animate(withDuration: 0.2) {
                self?.mainView.layoutSubviews()
            }
        }).disposed(by: disposeBag)
    }
    
    public class func createInstance(presenter : PinCodePresenterProtocol) -> PinCodeVC {
        let instance = PinCodeVC()
        instance.presenter = presenter
        return instance
    }
    
    public func changeState(_ state: PinCodeViewState) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            switch state {
            case .normal:
                self?.mainView.errorLabel.alpha = 0.0
                if let count = self?.pincode.count {
                    self?.mainView.dots.updateState(.filled(count: count))
                }
            case .error:
                self?.mainView.errorLabel.alpha = 1.0
                self?.mainView.dots.updateState(.error)
                self?.pincode = ""
            case .success:
                self?.mainView.errorLabel.alpha = 0.0
                self?.mainView.dots.updateState(.success)
            }
        }
    }
    
    @objc func policyPressed() {
        presenter.policyPressed()
    }
    
    @objc func biometricsPressed() {
        presenter.biometricsPressed()
    }
    
    @objc func forgotPressed() {
        presenter.forgotPressed()
    }
    
    @objc func erasePressed() {
        if pincode.count > 0 {
            pincode.removeLast()
        }
        pinCodeChanged()
    }
    
    private func pinCodeChanged() {
        mainView.dots.updateState(.filled(count: pincode.count))
        if mainView.errorLabel.alpha == 1.0 {
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.mainView.errorLabel.alpha = 0.0
            }
        }
        if pincode.count == mainView.dots.count {
            presenter.pinCodeEntered(pincode)
        }
    }
}

extension PinCodeVC : DigitButtonDelegate {
    public func digitPressed(_ digit: Int) {
        guard pincode.count < mainView.dots.count else { return }
        pincode = "\(pincode)\(digit)"
        pinCodeChanged()
    }
}
