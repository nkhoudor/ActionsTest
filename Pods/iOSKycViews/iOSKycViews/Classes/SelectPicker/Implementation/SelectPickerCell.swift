//
//  SelectPickerCell.swift
//  iOSKyc
//
//  Created by Nik on 24/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import PinLayout

class SelectPickerCell: UITableViewCell {
    static let reuseIdentifier = "SelectPickerCell"
    
    let nameLabel = UILabel()
    private let padding: CGFloat = 22

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        separatorInset = .zero
        
        contentView.addSubview(nameLabel)
        selectedBackgroundView = UIView.clearView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
    }
    
    private func layout() {
        nameLabel.pin.top(padding).horizontally(16).sizeToFit(.width)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        return CGSize(width: contentView.frame.width, height: nameLabel.frame.maxY + padding)
    }
}

