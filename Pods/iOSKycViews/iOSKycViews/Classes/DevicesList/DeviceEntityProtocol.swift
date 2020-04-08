//
//  DeviceEntityProtocol.swift
//  iOSKyc
//
//  Created by Nik on 27/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit

public protocol DeviceEntityProtocol {
    func getName() -> String
    func getDescripition() -> String
    func configureImage(_ image: UIImageView)
}
