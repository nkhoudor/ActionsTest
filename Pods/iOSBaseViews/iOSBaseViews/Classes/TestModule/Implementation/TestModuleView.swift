//
//  TestModuleView.swift
//  Vivex
//
//  Created by Nik, 7/01/2020
//

import Foundation
import PinLayout

public struct TestModuleFactory {
    let name : String
    let usePresentation : Bool
    let controller : () -> UIViewController
    
    public init(name: String, usePresentation: Bool, controller: @escaping () -> UIViewController) {
        self.name = name
        self.usePresentation = usePresentation
        self.controller = controller
    }
}

protocol TestModuleViewDelegate : class {
    func moduleSelected(module: TestModuleFactory)
}

public class TestModuleView : UIView {
    var configurator: TestModuleConfiguratorProtocol!
    
    private let tableView = UITableView()
    private var modules: [TestModuleFactory] = []
    weak var delegate: TestModuleViewDelegate?
    
    init(configurator: TestModuleConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        backgroundColor = .white

        tableView.estimatedRowHeight = 10
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.tableFooterView = UIView()
        tableView.register(ModuleCell.self, forCellReuseIdentifier: ModuleCell.reuseIdentifier)
        addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(modules: [TestModuleFactory]) {
        self.modules = modules
        tableView.reloadData()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        tableView.pin.all()
    }
}

extension TestModuleView: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modules.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ModuleCell.reuseIdentifier, for: indexPath) as! ModuleCell
        cell.configure(name: modules[indexPath.row].name)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let module = modules[indexPath.row]
        delegate?.moduleSelected(module: module)
    }
}
