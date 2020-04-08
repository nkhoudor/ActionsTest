//
//  ModuleCell.swift
//  iOSBaseViews
//
//  Created by Nik on 07/01/2020.
//

import UIKit
import PinLayout

class ModuleCell: UITableViewCell {
    static let reuseIdentifier = "ModuleCell"
    
    private let nameLabel = UILabel()
    private let padding: CGFloat = 30

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        separatorInset = .zero
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(name: String) {
        nameLabel.text = name
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        nameLabel.pin.vCenter().horizontally(16).sizeToFit(.width)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // 1) Set the contentView's width to the specified size parameter
        contentView.pin.width(size.width)

        // 2) Layout the contentView's controls
        layout()
        
        // 3) Returns a size that contains all controls
        return CGSize(width: contentView.frame.width, height: nameLabel.frame.maxY + padding)
    }
}

