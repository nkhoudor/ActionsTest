//
//  MaskCameraRouter.swift
//
//  Created by Nik, 17/01/2020
//

import UIKit

public class MaskCameraRouter : MaskCameraRouterProtocol {
    public init() {}
    
    public var imageTaken : ((Data) -> ())?
}
