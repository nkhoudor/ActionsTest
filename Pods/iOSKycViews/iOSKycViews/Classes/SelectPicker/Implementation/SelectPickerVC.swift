//
//  SelectPickerVC.swift
//  Vivex
//
//  Created by Nik, 24/02/2020
//

import Foundation
import UIKit
import RxSwift

public class SelectPickerVC : UIViewController, SelectPickerViewProtocol {
    var presenter : SelectPickerPresenterProtocol!
    
    let disposeBag = DisposeBag()
    
    private var mainView: SelectPickerView {
        return view as! SelectPickerView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = SelectPickerView(configurator: presenter.configurator)
        
        presenter.getValuesObservable().bind(to: mainView.tableView.rx.items(cellIdentifier: SelectPickerCell.reuseIdentifier, cellType: SelectPickerCell.self)) {[weak self] (row, element, cell) in
            self?.presenter.configurator.valueLabelConfigurationFactory(cell.nameLabel)
            cell.nameLabel.text = element
        }.disposed(by: disposeBag)
        
        mainView.tableView.allowsSelection = true
        
        mainView.tableView.rx.modelSelected(String.self).subscribe(onNext: { [weak self] value in
            self?.presenter.valueSelected(value)
        }).disposed(by: disposeBag)
    }
    
    public class func createInstance(presenter : SelectPickerPresenterProtocol) -> SelectPickerVC {
        let instance = SelectPickerVC()
        instance.presenter = presenter
        return instance
    }
}
