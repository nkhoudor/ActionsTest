//
//  SDKCoreConfigurable.swift
//  iOSBankingSDK
//
//  Created by Maxim MAMEDOV on 20.02.2020.
//

import Foundation

public struct SDKCoreConfig : Codable {
    public let production: Bool
    public let appHost: String
    public let wsConnection: WSConnection
    public let authService: AuthService
    public let dvsChunks : [DVSChunk]
}

public struct WSConnection : Codable {
    public let url: String
    public let path: String
    public let multiplex: Bool
    public let ackTimeout: Int
}

public struct AuthService : Codable {
    public let host: String
    public let loginPath: String
    public let logoutPath: String
    public let refreshPath: String
}

public struct DVSChunk : Codable {
    public let holderMSPID: String
    public let holderAff: String
    public let postUrl: String
    public let getUrl: String
}

public protocol SDKCoreConfigurable : Configurable {
    func configure(server: String, config: SDKCoreConfig?)
}
