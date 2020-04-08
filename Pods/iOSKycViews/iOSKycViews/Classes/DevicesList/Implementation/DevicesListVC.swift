//
//  DevicesListVC.swift
//  Vivex
//
//  Created by Nik, 26/01/2020
//

import Foundation
import UIKit

public class DevicesListVC : UIViewController, DevicesListViewProtocol {
    var presenter : DevicesListPresenterProtocol!
    
    var devices : [DeviceEntityProtocol] = []
    
    private var mainView: DevicesListView {
        return view as! DevicesListView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = DevicesListView(configurator: presenter.configurator)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        resendInText = mainView.resendInLabel.text ?? ""
        mainView.sendButton.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
        mainView.recoverButton.addTarget(self, action: #selector(recoverPressed), for: .touchUpInside)
    }
    
    @objc func sendPressed() {
        presenter.sendPressed()
    }
    
    @objc func recoverPressed() {
        presenter.recoverPressed()
    }
    
    var resendInText : String = ""
    
    private var viewAppeared : Bool = false
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewAppeared = true
    }
    
    public func changeResendState(_ state: AuthResendState) {
        switch state {
        case .send:
            changeResendStateImpl(state)
        default:
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.changeResendStateImpl(state)
            }
        }
    }
    
    private func changeResendStateImpl(_ state: AuthResendState) {
        switch state {
        case .send:
            mainView.sendLabel.alpha = 1.0
            mainView.resendInLabel.alpha = 0.0
            mainView.resendLabel.alpha = 0.0
            mainView.sendButtonShadowLayer.isHidden = false
            mainView.sendButtonProhibitedLayer.isHidden = true
            mainView.sendButton.isUserInteractionEnabled = true
        case .resend(let seconds):
            mainView.sendLabel.alpha = 0.0
            mainView.resendInLabel.alpha = 1.0
            mainView.resendInLabel.text = "\(resendInText) \(seconds)"
            mainView.resendLabel.alpha = 0.0
            mainView.sendButtonShadowLayer.isHidden = true
            mainView.sendButtonProhibitedLayer.isHidden = false
            mainView.sendButton.isUserInteractionEnabled = false
        case .resendAllowed:
            mainView.sendLabel.alpha = 0.0
            mainView.resendInLabel.alpha = 0.0
            mainView.resendLabel.alpha = 1.0
            mainView.sendButtonShadowLayer.isHidden = false
            mainView.sendButtonProhibitedLayer.isHidden = true
            mainView.sendButton.isUserInteractionEnabled = true
        }
    }
    
    public func updateDevices(_ devices: [DeviceEntityProtocol]) {
        self.devices = devices
        mainView.tableView.reloadData()
        if !viewAppeared {
            mainView.layoutSubviews()
        } else {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.mainView.layoutSubviews()
            }
        }
    }
    
    public class func createInstance(presenter : DevicesListPresenterProtocol) -> DevicesListVC {
        let instance = DevicesListVC()
        instance.presenter = presenter
        return instance
    }
}

extension DevicesListVC : UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeviceListCell.reuseIdentifier) as! DeviceListCell
        presenter.configurator.cellNameConfigurationFactory(cell.nameLabel)
        presenter.configurator.cellDescriptionConfigurationFactory(cell.descriptionLabel)
        let device = devices[indexPath.row]        
        cell.nameLabel.text = device.getName()
        cell.descriptionLabel.text = device.getDescripition()
        return cell
    }
}
