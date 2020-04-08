//
//  CountryPickerView.swift
//  Vivex
//
//  Created by Nik, 1/02/2020
//

import Foundation
import PinLayout

public class CountryPickerView : UIView {
    var configurator: CountryPickerConfiguratorProtocol!
    
    var textField : LimitedLengthTextField!
    var underline = UIView()
    var cancelButton : UIButton!
    var tableView = UITableView()
    var serviceUnavailableLabel : UILabel!
    
    init(configurator: CountryPickerConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        
        backgroundColor = configurator.backgroundColor
        
        textField = LimitedLengthTextField.copy(textField: configurator.textFieldFactory())
        textField.maxLength = configurator.textFieldMaxLength
        underline.backgroundColor = configurator.underlineColor
        cancelButton = configurator.cancelButtonFactory()
        tableView.register(CountryPickerCell.self, forCellReuseIdentifier: CountryPickerCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        
        serviceUnavailableLabel = configurator.serviceUnavailableLabelFactory()
        serviceUnavailableLabel.alpha = 0.0
        
        addSubview(textField)
        addSubview(underline)
        addSubview(cancelButton)
        addSubview(tableView)
        addSubview(serviceUnavailableLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        textField.pin.top(15).left(16).right(35.0 + 16.0).sizeToFit(.width)
        cancelButton.pin.size(CGSize(width: 24, height: 24)).right(21).vCenter(to: textField.edge.vCenter)
        underline.pin.below(of: textField).marginTop(20).left().right().height(1)
        
        tableView.pin.below(of: underline).left().right().bottom()
        
        serviceUnavailableLabel.pin.below(of: underline).marginTop(18).left(16).right(16).sizeToFit(.width)
    }
}
