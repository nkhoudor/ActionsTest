//
//  HomeAddressFormVC.swift
//  Vivex
//
//  Created by Nik, 22/01/2020
//

import Foundation
import UIKit

public class HomeAddressFormVC : UIViewController, HomeAddressFormViewProtocol {
    var presenter : HomeAddressFormPresenterProtocol!
    
    private var mainView: HomeAddressFormView {
        return view as! HomeAddressFormView
    }
    
    let inputs = ["Country", "City", "Region", "Street", "House number", "Postal code"]
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = HomeAddressFormView(inputs: inputs, configurator: presenter.configurator)
        for tf in mainView.textFields.map({ $0.textField }) {
            tf?.delegate = self
            //tf?.addTarget(self, action: #selector(textFieldTouched(textField:)), for: .editingDidBegin)
        }
        mainView.submitButton.addTarget(self, action: #selector(submitPressed), for: .touchUpInside)
    }
    
    var swipeVC : UIViewController!
    
    @objc func textFieldTouched(textField: UITextField) {
        if let index = mainView.textFields.firstIndex(where: { $0.textField == textField }), index == 0 {
            //mainView.endEditing(true)
            mainView.textFields.forEach({ $0.textField.resignFirstResponder() })
            /*let interactor = presenter.configurator.countryPickerInteractorFactory()
            let configurator = presenter.configurator.countryPickerConfiguratorFactory()
            let router = CountryPickerRouter()
            router.cancelPressed = { [weak self] in
                self?.swipeVC.dismiss(animated: true)
                self?.mainView.textFields[index].textField.text = ""
                self?.mainView.textFields[index].textFieldDidEnd(textField)
            }
            router.countrySelected = { [weak self] country in
                self?.swipeVC.dismiss(animated: true)
                self?.mainView.textFields[index].textField.text = country.name
                self?.mainView.textFields[index].textFieldDidEnd(textField)
            }
            let vcFactory = {
                CountryPickerVC.createInstance(presenter: CountryPickerPresenter(interactor: interactor, router: router, configurator: configurator))
            }
            swipeVC = HalfSceenModalVC.createInstance(configurator: presenter.configurator.halfScreenModalConfigurator(), presentingVCFactory: vcFactory, baseVC: self)
            swipeVC.modalPresentationStyle = .overCurrentContext
            swipeVC.modalTransitionStyle = .coverVertical
            present(swipeVC, animated: true, completion: nil)*/
        } else {
            mainView.scrollRectToVisible(textField.frame, animated: true)
        }
    }
    
    @objc func submitPressed() {
        var fields : [AddressField] = []
        for (i, tf) in mainView.textFields.map({ $0.textField }).enumerated() {
            if let text = tf?.text, !text.isEmpty {
                fields.append(AddressField(name: inputs[i], value: text))
            } else {
                tf?.becomeFirstResponder()
                return
            }
        }
        presenter.addressReady(address: AddressInfoModel(values: fields))
    }
    
    public class func createInstance(presenter : HomeAddressFormPresenterProtocol) -> HomeAddressFormVC {
        let instance = HomeAddressFormVC()
        instance.presenter = presenter
        return instance
    }
}

extension HomeAddressFormVC : UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let index = mainView.textFields.firstIndex(where: { $0.textField == textField }), index == 0 {
            mainView.endEditing(true)
            let interactor = presenter.configurator.countryPickerInteractorFactory()
            let configurator = presenter.configurator.countryPickerConfiguratorFactory()
            let router = CountryPickerRouter()
            router.cancelPressed = { [weak self] in
                self?.swipeVC.dismiss(animated: true)
                self?.mainView.textFields[index].textField.text = ""
                self?.mainView.textFields[index].textFieldDidEnd(textField)
            }
            router.countrySelected = { [weak self] country in
                self?.swipeVC.dismiss(animated: true)
                self?.mainView.textFields[index].textField.text = country.name
                self?.mainView.textFields[index].textFieldDidEnd(textField)
            }
            let vcFactory = {
                CountryPickerVC.createInstance(presenter: CountryPickerPresenter(interactor: interactor, router: router, configurator: configurator))
            }
            swipeVC = HalfSceenModalVC.createInstance(configurator: presenter.configurator.halfScreenModalConfigurator(), presentingVCFactory: vcFactory, baseVC: self)
            swipeVC.modalPresentationStyle = .overCurrentContext
            swipeVC.modalTransitionStyle = .coverVertical
            present(swipeVC, animated: true, completion: nil)
            mainView.scrollRectToVisible(textField.frame, animated: true)
            return false
        } else {
            mainView.scrollRectToVisible(textField.frame, animated: true)
            return true
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tfs = mainView.textFields.map({ $0.textField })
        if let index = tfs.firstIndex(where: { $0 == textField }), index < tfs.count - 1 {
            tfs[index + 1]?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
