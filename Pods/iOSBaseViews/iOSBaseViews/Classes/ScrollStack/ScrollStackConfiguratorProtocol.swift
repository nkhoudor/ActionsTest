//
//  ScrollStackConfiguratorProtocol.swift
//
//  Created by Nik, 6/01/2020
//

import Foundation

public protocol ScrollStackConfiguratorProtocol {
    var backgroundColor : UIColor { get }
    
    var modules : [Factory<UIViewController>] { get }
    
    ///Margins between modules including top and bottom margin. Should be modules.size + 1
    var margins : [CGFloat] { get }
}
