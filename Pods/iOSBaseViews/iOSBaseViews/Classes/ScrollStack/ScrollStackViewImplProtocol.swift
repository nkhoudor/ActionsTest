//
//  ScrollStackViewImplProtocol.swift
//  iOSBaseViews
//
//  Created by Nik on 09/01/2020.
//

import Foundation

public protocol ScrollStackViewImplProtocol : UIScrollView {
    init(configurator: ScrollStackConfiguratorProtocol)
    func setupViews(_ views: [UIView])
}
