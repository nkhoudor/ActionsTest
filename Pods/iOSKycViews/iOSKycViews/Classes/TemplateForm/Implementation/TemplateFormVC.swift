//
//  TemplateFormVC.swift
//  Vivex
//
//  Created by Nik, 20/02/2020
//

import Foundation
import UIKit
import IQKeyboardManagerSwift
import iOSBaseViews

public class TemplateFormVC : UIViewController, TemplateFormViewProtocol {
    var presenter : TemplateFormPresenterProtocol!
    
    var swipeVC : UIViewController!
    
    private var mainView: TemplateFormView {
        return view as! TemplateFormView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 100
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        IQKeyboardManager.shared.enable = false
    }
    
    public override func loadView() {
        let config = presenter.getConfig()
        view = TemplateFormView(config: config, configurator: presenter.configurator)
        mainView.submitButton.addTarget(self, action: #selector(submitPressed), for: .touchUpInside)
        for tf in mainView.textFields.map({ $0.textField }) {
            tf?.delegate = self
        }
    }
    
    @objc func submitPressed() {
        var firstResponder : UITextField?
        for (i, field) in presenter.getConfig().fields.enumerated() {
            if let selectField = field as? SelectFormFieldTemplateProtocol {
                field.result = selectField.values.first(where: { $0.viewValue == mainView.textFields[i].textField.text })?.value
            } else {
                field.result = mainView.textFields[i].textField.text
            }
            
            if !field.isValid() {
                mainView.textFields[i].textFieldDidChange(mainView.textFields[i].textField)
                
                if firstResponder == nil {
                    firstResponder = mainView.textFields[i].textField
                }
            }
        }
        
        if firstResponder != nil {
            firstResponder!.becomeFirstResponder()
            return
        }
        
        presenter.submitPressed()
    }
    
    public class func createInstance(presenter : TemplateFormPresenterProtocol) -> TemplateFormVC {
        let instance = TemplateFormVC()
        instance.presenter = presenter
        return instance
    }
}

extension TemplateFormVC : UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let index = mainView.textFields.firstIndex(where: { $0.textField == textField }) {
            switch presenter.getConfig().fields[index] {
            
            
            case is SelectFormFieldTemplateProtocol:
                mainView.endEditing(true)
                let interactor = presenter.configurator.selectPickerInteractorFactory()
                let field = presenter.getConfig().fields[index] as! SelectFormFieldTemplateProtocol
                interactor.setValues(field.values.map({ $0.viewValue }))
                let configurator = presenter.configurator.selectPickerConfiguratorFactory()
                
                let router = SelectPickerRouter()
                router.valueSelected = { [weak self] value in
                    self?.swipeVC.dismiss(animated: true)
                    self?.mainView.textFields[index].textField.text = value
                    self?.mainView.textFields[index].textFieldDidEnd(textField)
                }
                
                let vcFactory = {
                    SelectPickerVC.createInstance(presenter: SelectPickerPresenter(interactor: interactor, router: router, configurator: configurator))
                }
                let selectPickerHalfScreenModalConfigurator = presenter.configurator.selectPickerHalfScreenModalConfigurator(field.title)
                
                swipeVC = HalfSceenModalVC.createInstance(configurator: selectPickerHalfScreenModalConfigurator, presentingVCFactory: vcFactory, baseVC: self)
                swipeVC.modalPresentationStyle = .overCurrentContext
                swipeVC.modalTransitionStyle = .coverVertical
                present(swipeVC, animated: true, completion: nil)
                mainView.scrollRectToVisible(textField.frame, animated: true)
                return false
                
            
            case is CountryPickerFormFieldTemplateProtocol:
                mainView.endEditing(true)
                let interactor = presenter.configurator.countryPickerInteractorFactory()
                //let field = presenter.getConfig().fields[index] as! CountryPickerFormFieldTemplate
                //interactor.setCountries(countryCodes: field.countries)
                var configurator = presenter.configurator.countryPickerConfiguratorFactory()
                configurator.textFieldMaxLength = (presenter.getConfig().fields[index] as! CountryPickerFormFieldTemplateProtocol).maxLength
                
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
            default:
                ()
            }
        }
        return true
    }
}
