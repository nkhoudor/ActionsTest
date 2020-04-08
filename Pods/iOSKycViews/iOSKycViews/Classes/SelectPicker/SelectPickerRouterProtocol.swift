//
//  SelectPickerRouterProtocol.swift
//
//  Created by Nik, 24/02/2020
//

import Foundation

public protocol SelectPickerRouterProtocol {
    var valueSelected : ((String) -> ())? { get }
}
