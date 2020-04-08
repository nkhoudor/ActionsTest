//
//  CountryPickerCell.swift
//  iOSKyc
//
//  Created by Nik on 01/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import PinLayout

class CountryPickerCell: UITableViewCell {
    static let reuseIdentifier = "CountryPickerCell"
    
    let nameLabel = UILabel()
    let flagImageView = UIImageView()
    private let padding: CGFloat = 22

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //selectionStyle = .none
        separatorInset = .zero
        
        contentView.addSubview(flagImageView)
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
        flagImageView.image = nil
    }
    
    private func layout() {
        flagImageView.pin.size(CGSize(width: 20, height: 15)).left(16).top(padding)
        nameLabel.pin.right(of: flagImageView, aligned: .center).marginLeft(16).right(16).sizeToFit(.width)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        layout()
        return CGSize(width: contentView.frame.width, height: nameLabel.frame.maxY + padding)
    }
}

