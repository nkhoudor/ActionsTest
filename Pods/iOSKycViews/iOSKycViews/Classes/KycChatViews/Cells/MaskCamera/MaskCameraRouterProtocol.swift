//
//  MaskCameraRouterProtocol.swift
//
//  Created by Nik, 17/01/2020
//

import UIKit

public protocol MaskCameraRouterProtocol {
    var imageTaken : ((Data) -> ())? { get }
}
