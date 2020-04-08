//
//  FrameImageView.swift
//  iOSBaseViews
//
//  Created by Nik on 09/01/2020.
//

import Foundation

public class FrameImageView : UIView {
    
    lazy var imageView : UIImageView = {
        let iv = UIImageView()
        addSubview(iv)
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        imageView.pin.center().sizeToFit()
    }
}
