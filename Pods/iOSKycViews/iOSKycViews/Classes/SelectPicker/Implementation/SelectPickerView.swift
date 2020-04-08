//
//  SelectPickerView.swift
//  Vivex
//
//  Created by Nik, 24/02/2020
//

import Foundation
import PinLayout

public class SelectPickerView : UIView {
    var configurator: SelectPickerConfiguratorProtocol!
    
    var tableView = UITableView()
    
    init(configurator: SelectPickerConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        
        backgroundColor = configurator.backgroundColor
        
        tableView.register(SelectPickerCell.self, forCellReuseIdentifier: SelectPickerCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        tableView.pin.all()
    }
}
