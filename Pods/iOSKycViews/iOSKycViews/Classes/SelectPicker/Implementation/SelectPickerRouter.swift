//
//  SelectPickerRouter.swift
//
//  Created by Nik, 24/02/2020
//

import Foundation

public class SelectPickerRouter : SelectPickerRouterProtocol {
    public init() {}
    public var valueSelected: ((String) -> ())?
}
