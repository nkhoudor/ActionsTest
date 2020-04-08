//
//  DeviceListCell.swift
//  iOSKyc
//
//  Created by Nik on 26/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import PinLayout

class DeviceListCell : UITableViewCell {
    lazy var pixel = UIScreen.main.bounds.height / 811
    static let reuseIdentifier = "DeviceListCell"
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let deviceImageView = UIImageView()
    private let padding: CGFloat = 30

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        separatorInset = .zero
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(deviceImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        deviceImageView.pin.width(pixel * 40).height(pixel * 40).right(16).vCenter()
        nameLabel.pin.bottom(to: edge.vCenter).left(16).right(pixel * 40 + 32).sizeToFit(.width)
        descriptionLabel.pin.top(to: edge.vCenter).left(16).right(pixel * 40 + 32).sizeToFit(.width)
        print(nameLabel.frame)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: pixel * 76)
    }
}
