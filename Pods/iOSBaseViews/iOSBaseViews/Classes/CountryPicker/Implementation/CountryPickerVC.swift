//
//  CountryPickerVC.swift
//  Vivex
//
//  Created by Nik, 1/02/2020
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import FlagKit

public class CountryPickerVC : UIViewController, CountryPickerViewProtocol {
    var presenter : CountryPickerPresenterProtocol!
    
    var countries : [CountryEntityProtocol] = []
    
    let disposeBag = DisposeBag()
    
    private var mainView: CountryPickerView {
        return view as! CountryPickerView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    var serviceUnavailableText : String = ""
    
    public override func loadView() {
        view = CountryPickerView(configurator: presenter.configurator)
        
        serviceUnavailableText = mainView.serviceUnavailableLabel.text ?? ""
        
        presenter.getCountriesObservable().bind(to: mainView.tableView.rx.items(cellIdentifier: "CountryPickerCell", cellType: CountryPickerCell.self)) {[weak self] (row, element, cell) in
            self?.presenter.configurator.countryNameLabelConfigurationFactory(cell.nameLabel)
            cell.nameLabel.text = element.name
            cell.flagImageView.image = Flag(countryCode: element.countryCode)?.originalImage
        }.disposed(by: disposeBag)
        
        presenter.getCountriesObservable().subscribe(onNext: {[weak self] countries in
            UIView.animate(withDuration: 0.3) {
                self?.mainView.tableView.alpha = countries.count == 0 ? 0.0 : 1.0
                self?.mainView.serviceUnavailableLabel.alpha = countries.count == 0 ? 1.0 : 0.0
            }
        }).disposed(by: disposeBag)
        
        mainView.tableView.allowsSelection = true
        
        mainView.tableView.rx.modelSelected(CountryEntityProtocol.self).subscribe(onNext: { [weak self] country in
            self?.presenter.countrySelected(country)
        }).disposed(by: disposeBag)
        
        mainView.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        mainView.textField.addTarget(self, action: #selector(textFieldDidBegin(_:)), for: .editingDidBegin)
        textFieldPlaceHolder = mainView.textField.text ?? ""
        mainView.cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
    }
    
    var textFieldPlaceHolder : String = ""
    
    @objc func textFieldDidBegin(_ textField: UITextField) {
        if textField.text == textFieldPlaceHolder {
            textField.text = ""
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        mainView.serviceUnavailableLabel.text = "\(serviceUnavailableText) \"\(textField.text ?? "")\""
        presenter.searchKeywordChanged(textField.text ?? "")
    }
    
    @objc func cancelPressed() {
        presenter.cancelPressed()
    }
    
    public class func createInstance(presenter : CountryPickerPresenterProtocol) -> CountryPickerVC {
        let instance = CountryPickerVC()
        instance.presenter = presenter
        return instance
    }
}
