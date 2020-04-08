//
//  ConnectionProfile.swift
//  iOSKyc
//
//  Created by Nik on 26/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSKycSDK
import iOSCoreSDK

class ConnectionProfile : Codable {
    let kyc: String
    let config: SDKCoreConfig
}
