//
//  EmitEvent.swift
//  iOSBankingSDK
//
//  Created by Maxim MAMEDOV on 20.02.2020.
//

import Foundation

public protocol EmitProtocol {
    var emit : (name: String, data: Codable?) { get }
}

enum EmitEvent : EmitProtocol {
    // Core
    case PING
    case LOGOUT
    case INIT_REQ(uuid: String, config: SDKCoreConfig)
    
    // Storage
    case AUTH(jwt: String?)
    case GET_KEYS_RES(uuid: String, success: Bool, data: [String])
    case SET_ITEM_RES(uuid: String, success: Bool)
    case REMOVE_ITEM_RES(uuid: String, success: Bool)
    case GET_ITEM_RES(uuid: String, success: Bool, value: String?)
    
    var emit : (name: String, data: Codable?) {
        switch self {
            
        case .PING:
            return (name: "s-ping", data: nil)
            
        case .LOGOUT:
            return (name: "Core.App.Logout", data: nil)
            
        case .INIT_REQ(let uuid, let config):
            return (name: "Core.App.Init.Req", data: InitReq(uuid: uuid, data: config))
            
        case .GET_KEYS_RES(let uuid, let success, let data):
            return (name: "Storage.App.GetKeys.Res", GetKeysRes(uuid: uuid, success: success, data: data))
            
        case .SET_ITEM_RES(let uuid, let success):
            return (name: "Storage.App.SetItem.Res", SetItemRes(uuid: uuid, success: success))
            
        case .REMOVE_ITEM_RES(let uuid, let success):
            return (name: "Storage.App.RemoveItem.Res", RemoveItemRes(uuid: uuid, success: success))
        
        case .GET_ITEM_RES(let uuid, let success, let value):
            return (name: "Storage.App.GetItem.Res", GetItemRes(uuid: uuid, success: success, data: value))
            
        case .AUTH(let jwt):
            return (name: "auth", jwt)
            
        }
    }
}

public struct JWTData: Codable {
    let tokenExp: Int?
    let refreshTokenExp: Int?
    let iat: Int?
    let refreshToken: String?
    let token: String?
}

//INIT_REQ
struct InitReq : Codable {
    let uuid : String
    let data : SDKCoreConfig
}

//GET_KEYS_RES
struct GetKeysRes : Codable {
    let uuid : String
    let success : Bool
    let data : [String]
}

//SET_ITEM_RES
struct SetItemRes : Codable {
    let uuid : String
    let success : Bool
}

//REMOVE_ITEM_RES
struct RemoveItemRes : Codable {
    let uuid : String
    let success : Bool
}

//GET_ITEM_RES
struct GetItemRes : Codable {
    let uuid : String
    let success : Bool
    let data : String?
}
